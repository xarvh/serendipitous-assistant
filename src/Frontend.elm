port module Frontend exposing (..)

import Browser
import Browser.Navigation
import Chars exposing (..)
import Css
import Html exposing (Html)
import Html.Attributes as HA exposing (class, classList, style)
import Html.Events exposing (onClick)
import Json.Decode
import Json.Encode
import Lamdera
import List.Extra
import Types exposing (..)
import Url exposing (Url)


port xarvh_elm_notifications_to_js : { title : String, body : String, icon : String } -> Cmd msg


notificationCmd : { title : String, body : String } -> Cmd msg
notificationCmd { title, body } =
    xarvh_elm_notifications_to_js { body = body, title = title, icon = "" }


{-| Main
-}
type alias Model =
    FrontendModel


type alias Msg =
    FrontendMsg


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }



-- Support


type Page
    = PageSt
    | PageEdit
    | PagePick
    | PageChar Id


page : Model -> Page
page model =
    case model.url.path of
        "/st" ->
            PageSt

        "/edit" ->
            PageEdit

        s ->
            case s |> String.dropLeft 1 |> String.toInt of
                Nothing ->
                    PagePick

                Just id ->
                    PageChar id


isSt : Model -> Bool
isSt model =
    page model == PageSt


isEdit : Model -> Bool
isEdit model =
    page model == PageEdit


isSelected : Model -> Character -> Bool
isSelected model char =
    case page model of
        PageChar id ->
            char.id == id

        _ ->
            False


{-| Tea
-}
init : Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init url key =
    ( { characters = []
      , edit = ""
      , url = url
      , navKey = key
      }
    , Lamdera.sendToBackend TbRequestCharacters
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        UrlClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Cmd.none
                      --Cmd.batch [ Nav.pushUrl model.key (Url.toString url) ]
                    )

                Browser.External url ->
                    ( model
                    , Cmd.none
                      --Nav.load url
                    )

        OnRecklessSend toBackend ->
            ( model
            , Lamdera.sendToBackend toBackend
            )

        OnSelectCharacter id ->
            ( model
            , Browser.Navigation.pushUrl model.navKey <| "/" ++ String.fromInt id
            )

        OnTextareaInput s ->
            ( { model | edit = s }
            , case pcsFromString s of
                Ok pcs ->
                    Lamdera.sendToBackend <| TbJson pcs

                Err err ->
                    Cmd.none
            )


pcsFromString =
    Json.Decode.decodeString (Json.Decode.list characterDecoder)


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd Msg )
updateFromBackend msg model =
    case msg of
        TfCharacters pcs ->
            ( { model
                | characters = pcs
                , edit =
                    pcs
                        |> Json.Encode.list encodeCharacter
                        |> Json.Encode.encode 2
              }
            , makeNotifications model pcs
                |> List.map notificationCmd
                |> Cmd.batch
            )



-- Notifications


makeNotifications : Model -> List Character -> List { title : String, body : String }
makeNotifications model newCharacters =
    let
        xpIncreasedNotification newChar =
            case List.Extra.find (\oldPc -> oldPc.id == newChar.id) model.characters of
                Nothing ->
                    Nothing

                Just oldChar ->
                    if newChar.xps > oldChar.xps then
                        Just { title = newChar.name, body = "+1 XP!" }

                    else
                        Nothing

        cypherIncreasedNotification newChar =
            case List.Extra.find (\oldPc -> oldPc.id == newChar.id) model.characters of
                Nothing ->
                    Nothing

                Just oldChar ->
                    if List.length newChar.cyphers > List.length oldChar.cyphers then
                        Just { title = newChar.name, body = "+1 Cypher!" }

                    else
                        Nothing

        chars =
            List.filter (isSelected model) newCharacters
    in
    List.concat
        [ List.filterMap xpIncreasedNotification chars
        , List.filterMap cypherIncreasedNotification chars
        ]



-- View


view : Model -> Browser.Document Msg
view model =
    { title = pageTitle model ++ " - Mercy of the Icons"
    , body =
        [ case page model of
            PageEdit ->
                viewEdit model.edit

            PagePick ->
                viewWhoAreYou model

            _ ->
                Html.div
                    [ class "justifyCenter" ]
                    [ model.characters
                        |> List.sortBy .name
                        |> List.partition (isSelected model)
                        |> (\( myChar, otherChars ) -> myChar ++ otherChars)
                        |> List.map (viewCharacter model)
                        |> Html.div [ class "mr2" ]
                    ]
        , Html.node "style"
            []
            [ Html.text Css.css ]
        , Html.node "link"
            [ HA.href "https://fonts.googleapis.com/css2?family=Electrolize&display=swap"
            , HA.rel "stylesheet"
            ]
            []
        ]
    }


pageTitle : Model -> String
pageTitle model =
    case page model of
        PageChar id ->
            case List.Extra.find (\char -> char.id == id) model.characters of
                Nothing ->
                    "Player"

                Just char ->
                    char.name

        PageSt ->
            "Storyteller"

        PageEdit ->
            "Edit"

        PagePick ->
            "Pick your character"


viewWhoAreYou : Model -> Html Msg
viewWhoAreYou model =
    Html.div
        []
        [ Html.h3 [] [ Html.text "Who are you?" ]
        , model.characters
            |> List.sortBy .name
            |> List.map (\c -> Html.button [ onClick <| OnSelectCharacter c.id ] [ Html.text c.name ])
            |> Html.div []
        ]


onRecklessClick : ToBackend -> Html.Attribute Msg
onRecklessClick tb =
    onClick <| OnRecklessSend tb



-- View edit


viewEdit : String -> Html Msg
viewEdit content =
    Html.div
        []
        [ Html.textarea
            [ Html.Events.onInput OnTextareaInput
            , style "width" "100%"
            , style "height" "90vh"
            ]
            [ Html.text content ]
        , Html.div
            []
            [ case pcsFromString content of
                Ok _ ->
                    Html.text "Ok!"

                Err err ->
                    err
                        |> Json.Decode.errorToString
                        |> Html.text
            ]
        ]



-- View character


type alias ViewStatRowArgs =
    { label : String
    , number : Int
    , onAdd : Maybe ToBackend
    , onUse : Maybe ToBackend
    , bar :
        Maybe
            { pool : Pool
            , committedColor : String
            , availableColor : String
            , usedColor : String
            }
    }


viewBar : String -> Int -> Html Msg
viewBar backgroundColor value =
    if value == 0 then
        Html.text ""

    else
        Html.div
            [ style "width" <| String.fromInt value ++ "em"
            , style "background-color" backgroundColor
            ]
            []


viewStatRow : ViewStatRowArgs -> Html Msg
viewStatRow args =
    let
        oc maybeOn attrs children =
            case maybeOn of
                Nothing ->
                    Html.text ""

                Just msg ->
                    Html.button (onRecklessClick msg :: attrs) children

        w n =
            style "width" (String.fromInt n ++ "rem")

        disableAdd =
            case args.bar of
                Nothing ->
                    False

                Just bar ->
                    bar.pool.used == 0
    in
    Html.div
        [ class "row mb1" ]
        [ Html.text ""
        , Html.div
            [ w 4 ]
            [ Html.text args.label ]
        , Html.div
            [ w 3
            , class "textRight mr2 nowrap"
            ]
            [ Html.text (String.fromInt args.number)
            , case args.bar of
                Nothing ->
                    Html.text ""

                Just bar ->
                    Html.span
                        [ class "small lowlight" ]
                        [ Html.text " / "
                        , Html.text (String.fromInt bar.pool.max)
                        ]
            ]
        , oc args.onUse
            [ HA.disabled (args.number < 1)
            , w 1
            ]
            [ Html.text "-" ]
        , oc args.onAdd
            [ HA.disabled disableAdd
            , w 1
            ]
            [ Html.text "+" ]
        , case args.bar of
            Nothing ->
                Html.text ""

            Just bar ->
                Html.div
                    [ class "row bar wideOnly ml2"
                    , style "border" <| bar.usedColor ++ " solid 2px"
                    ]
                    [ viewBar bar.committedColor bar.pool.committed
                    , viewBar bar.availableColor args.number
                    , viewBar bar.usedColor bar.pool.used
                    ]
        ]


viewTier : Int -> Html Msg
viewTier t =
    viewStatRow
        { label = "Tier"
        , number = t
        , onAdd = Nothing
        , onUse = Nothing
        , bar = Nothing
        }


viewPoints : Model -> Points -> Character -> Html Msg
viewPoints model p char =
    let
        ( label, n ) =
            case p of
                Experience ->
                    ( "XPs", char.xps )
    in
    viewStatRow
        { label = label
        , number = n
        , bar = Nothing
        , onAdd =
            if isSt model then
                Just <| TbDeltaPoints char.id p 1

            else
                Nothing
        , onUse =
            if isSelected model char then
                Just <| TbDeltaPoints char.id p -1

            else
                Nothing
        }


maybeViewAddCypher : Model -> Character -> Html Msg
maybeViewAddCypher model pc =
    if isSt model then
        Html.button
            [ onRecklessClick <| TbAddCypher pc.id ]
            [ Html.text "+" ]

    else
        Html.text ""


viewCharacter : Model -> Character -> Html Msg
viewCharacter model pc =
    Html.div
        [ class "card" ]
        [ Html.div
            [ class "mb1 styled"
            ]
            [ Html.text pc.name ]
        , Html.div
            [ class "row wrap" ]
            [ Html.img
                [ HA.src pc.url
                , class "portrait mb1 mr1"
                ]
                []
            , Html.div
                []
                [ viewPoints model Experience pc
                , if pc.pendingRecovery == 0 then
                    Html.text ""

                  else
                    Html.div
                        [ class "excess" ]
                        [ viewStatRow
                            { label = "recovered"
                            , number = pc.pendingRecovery
                            , bar = Nothing
                            , onAdd = Nothing
                            , onUse = Nothing
                            }
                        ]
                , viewPool model Might pc
                , viewPool model Speed pc
                , viewPool model Intellect pc
                ]
            ]
        , Html.div
            [ class "row wrap" ]
            [ Html.div
                [ class "mr2 mb2" ]
                [ List.range 0 3
                    |> List.map (viewRecovery model pc)
                    |> Html.div []
                ]
            , Html.div
                []
                (List.concat
                    [ List.indexedMap (viewCypher model pc) pc.cyphers
                    , [ maybeViewAddCypher model pc ]
                    ]
                )
            ]
        ]


poolTypeToString : PoolType -> String
poolTypeToString pt =
    case pt of
        Might ->
            "Might"

        Speed ->
            "Speed"

        Intellect ->
            "Intellect"


viewPool : Model -> PoolType -> Character -> Html Msg
viewPool model pt char =
    let
        ( pool, ( committedColor, availableColor, usedColor ) ) =
            case pt of
                Might ->
                    ( char.might
                    , ( "hsl(15,  23%, 30%)", "hsl(357, 100%, 72%)", "hsl(15, 100%, 95%)" )
                    )

                Speed ->
                    ( char.speed
                    , ( "hsl(54,  23%, 30%)", "hsl(140, 100%, 47%)", "hsl(140, 100%, 95%)" )
                    )

                Intellect ->
                    ( char.intellect
                    , ( "hsl(208,  23%, 30%)", "hsl(286, 100%, 50%)", "hsl(286, 100%, 95%)" )
                    )

        onAdd =
            if char.pendingRecovery > 0 && pool.used > 0 then
                Just <| TbDeltaPool char.id pt 1

            else
                Nothing
    in
    viewStatRow
        { label = poolTypeToString pt
        , number = pool.max - pool.used - pool.committed
        , onAdd = onAdd
        , onUse = Just <| TbDeltaPool char.id pt -1
        , bar =
            Just
                { pool = pool
                , committedColor = committedColor
                , availableColor = availableColor
                , usedColor = usedColor
                }
        }


viewRecovery : Model -> Character -> Int -> Html Msg
viewRecovery model char rec =
    let
        name =
            case rec of
                0 ->
                    "1 Action"

                1 ->
                    "10 minutes"

                2 ->
                    "1 hour"

                _ ->
                    "10 hours"

        isNext =
            char.nextRecovery == rec

        isClickable =
            isNext && isSelected model char
    in
    Html.div [ class "alignCenter" ]
        [ Html.button
            [ HA.disabled <| not isClickable
            , onRecklessClick <| TbRecovery char.id rec
            , class "mr1"
            , classList [ ( "hidden", not isClickable ) ]
            ]
            [ Html.text "D6 + "
            , char.tier
                + char.extraRecovery
                |> String.fromInt
                |> Html.text
            ]
        , Html.div
            [ classList [ ( "lowlight", not isNext ) ]
            ]
            [ Html.text name ]
        ]


viewCypher : Model -> Character -> Int -> CypherInstance -> Html Msg
viewCypher model pc index cypher =
    let
        usableSoFar =
            pc.cyphers
                |> List.take index
                |> List.filter (.used >> not)
                |> List.length

        isExcess =
            not cypher.used && usableSoFar >= pc.maxCyphers
    in
    Html.div
        [ class "row mb1" ]
        [ if isSelected model pc then
            Html.div
                []
                [ Html.button
                    [ class "mr1", onRecklessClick <| TbRemoveCypher pc.id index ]
                    [ if cypher.used then
                        Html.text "⨉"

                      else
                        Html.text "-"
                    ]
                ]

          else
            Html.text ""
        , Html.details
            []
            [ Html.summary
                [ classList
                    [ ( "excess", isExcess )
                    , ( "strikeout lowlight", cypher.used )
                    ]
                ]
                [ Html.text cypher.name ]
            , Html.div
                [ class "ml2 mb2" ]
                [ Html.div
                    [ class "mb1 bold" ]
                    [ Html.text <| "Level: " ++ String.fromInt cypher.level ]
                , cypher.info
                    |> String.replace "\n" " "
                    |> String.replace ". " ".\n"
                    |> String.split "\n"
                    |> List.map (\s -> Html.div [] [ Html.text s ])
                    |> Html.div []
                ]
            ]

        {-
           , Html.div
               [ class "tooltip" ]
               [ Html.div
                   [ class "mb2 bold"
                   ]
                   [ Html.text cypher.name ]
               , Html.div [] [ Html.text <| "Level: " ++ String.fromInt cypher.level ]
               , cypher.info
                   |> String.split "\n"
                   |> List.map (\s -> Html.p [] [ Html.text s ])
                   |> Html.div []
               ]
        -}
        ]
