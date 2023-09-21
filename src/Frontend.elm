module Frontend exposing (..)

import Browser
import Browser.Navigation
import Chars exposing (..)
import Css
import Html exposing (..)
import Html.Attributes as HA exposing (class, classList, style)
import Html.Events exposing (onClick)
import Json.Decode
import Json.Encode
import Lamdera
import Types exposing (..)
import Url exposing (Url)


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
            { model
                | characters = pcs
                , edit =
                    pcs
                        |> Json.Encode.list encodeCharacter
                        |> Json.Encode.encode 2
            }
                |> noCmd



-- View


view : Model -> Browser.Document Msg
view model =
    { title = "Serendepitous Assistant"
    , body =
        [ case page model of
            PageEdit ->
                viewEdit model.edit

            PagePick ->
                viewWhoAreYou model

            _ ->
                div
                    [ class "justifyCenter" ]
                    [ model.characters
                        |> List.sortBy .name
                        |> List.partition (isSelected model)
                        |> (\( myChar, otherChars ) -> myChar ++ otherChars)
                        |> List.map (viewCharacter model)
                        |> div [ class "mr2" ]

                    --                     , viewDisplayCypher model.displayCypher
                    ]
        , node "style"
            []
            [ Html.text Css.css ]
        , node "link"
            [ HA.href "https://fonts.googleapis.com/css2?family=Electrolize&display=swap"
            , HA.rel "stylesheet"
            ]
            []
        ]
    }


viewWhoAreYou : Model -> Html Msg
viewWhoAreYou model =
    div
        []
        [ h3 [] [ text "Who are you?" ]
        , model.characters
            |> List.sortBy .name
            |> List.map (\c -> button [ onClick <| OnSelectCharacter c.id ] [ text c.name ])
            |> div []
        ]


onRecklessClick : ToBackend -> Html.Attribute Msg
onRecklessClick tb =
    onClick <| OnRecklessSend tb



-- View edit


viewEdit : String -> Html Msg
viewEdit content =
    div
        []
        [ textarea
            [ Html.Events.onInput OnTextareaInput
            , style "width" "100%"
            , style "height" "90vh"
            ]
            [ text content ]
        , div
            []
            [ case pcsFromString content of
                Ok _ ->
                    text "Ok!"

                Err err ->
                    err
                        |> Json.Decode.errorToString
                        |> text
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


viewBar : String -> String -> Int -> Html Msg
viewBar backgroundColor borderColor value =
    if value == 0 then
        text ""

    else
        div
            [ style "width" <| String.fromInt value ++ "em"
            , style "background-color" backgroundColor
            ]
            []


viewStatRow : ViewStatRowArgs -> Html Msg
viewStatRow args =
    let
        oc maybeOn =
            case maybeOn of
                Nothing ->
                    class "hidden"

                Just msg ->
                    onRecklessClick msg

        w n =
            style "width" (String.fromInt n ++ "rem")
    in
    div
        [ class "row" ]
        [ div
            [ w 4 ]
            [ text args.label ]
        , div
            [ w 2
            , class "textRight"
            , class "mr2"
            ]
            [ text (String.fromInt args.number) ]
        , button
            [ oc args.onUse
            , HA.disabled (args.number < 1)
            , w 1
            ]
            [ text "-" ]
        , button
            [ oc args.onAdd
            , w 1
            , class "mr2"
            ]
            [ text "+" ]
        , case args.bar of
            Nothing ->
                text ""

            Just bar ->
                div
                    [ class "row bar"
                    , style "border" <| bar.usedColor ++ " solid 1px"
                    ]
                    [ viewBar bar.committedColor "none" bar.pool.committed
                    , viewBar bar.availableColor bar.usedColor args.number
                    , viewBar "none" bar.usedColor bar.pool.used
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


viewCharacter : Model -> Character -> Html Msg
viewCharacter model pc =
    div
        [ class "card" ]
        [ div
            [ class "mb1 styled"
            ]
            [ text pc.name ]
        , div
            [ class "media-layout"
            ]
            [ img
                [ HA.src pc.url
                , class "portrait mr2"
                ]
                []
            , table
                [ class "mr2" ]
                [ viewTier pc.tier
                , viewPoints model Experience pc
                , viewPool model Might pc
                , viewPool model Speed pc
                , viewPool model Intellect pc
                ]
            ]
        , div
            [ class "mt2 mr2 media-layout"
            ]
            [ div
                [ class "mr1" ]
                [ List.range 0 3
                    |> List.map (viewRecovery model pc)
                    |> div []
                ]
            , div
                [ class "ml2" ]
                (pc.cyphers
                    |> List.indexedMap (viewCypher model pc)
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
                    , ( "hsl(15,  23%, 30%)"
                      , "hsl(15, 100%, 50%)"
                      , "hsl(15, 100%, 90%)"
                      )
                    )

                Speed ->
                    ( char.speed
                    , ( "hsl(208,  23%, 30%)"
                      , "hsl(208, 100%, 50%)"
                      , "hsl(208, 100%, 90%)"
                      )
                    )

                Intellect ->
                    ( char.intellect
                    , ( "hsl(54,  23%, 30%)"
                      , "hsl(54, 100%, 50%)"
                      , "hsl(54, 100%, 90%)"
                      )
                    )
    in
    viewStatRow
        { label = poolTypeToString pt
        , number = pool.max - pool.used - pool.committed
        , onAdd = Just <| TbDeltaPool char.id pt 1
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
    div [ class "alignCenter" ]
        [ button
            [ HA.disabled <| not isClickable
            , onRecklessClick <| TbRecovery char.id rec
            , class "mr1"
            , classList [ ( "hidden", not isClickable ) ]
            ]
            [ text "D6 + "
            , char.tier
                + char.extraRecovery
                |> String.fromInt
                |> text
            ]
        , div
            [ classList [ ( "lowlight", not isNext ) ]
            ]
            [ text name ]
        ]


viewCypher : Model -> Character -> Int -> CypherInstance -> Html Msg
viewCypher model pc index cypher =
    div
        []
        [ if isSelected model pc then
            button [ class "mr1", onRecklessClick <| TbRemoveCypher pc.id index ] [ text "-" ]

          else
            text ""
        , span
            [ classList [ ( "excess", index >= pc.maxCyphers ) ] ]
            [ text cypher.name ]
        , div
            [ class "tooltip" ]
            [ div [ class "mb2 bold" ] [ text cypher.name ]
            , div [] [ text <| "Level: " ++ String.fromInt cypher.level ]
            , cypher.info
                |> String.split "\n"
                |> List.map (\s -> p [] [ text s ])
                |> div []
            ]
        ]
