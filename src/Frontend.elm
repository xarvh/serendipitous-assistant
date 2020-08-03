module Frontend exposing (..)

import Browser
import Browser.Navigation
import Chars exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
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
      , displayCypher = Nothing
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

        OnMouseEnterCypher cypher ->
            ( { model | displayCypher = cypher }
            , Cmd.none
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


css =
    """
body {
  background-color: black;
  color: white;
}

button {
  min-width: 2em;
}


/* Media */

.portrait {
  max-width: 8em;
  max-height: 10em;
}

.media-layout {
  display: flex;
}

/* TODO: use width instead */
@media (orientation: portrait) {
  .media-layout {
      flex-direction: column;
  }
  .portrait {
      display: none;
  }
}


/* atomic */

.flex { display: flex; }
.mr1 { margin-right: 0.5em; }
.mr2 { margin-right: 1em; }
.w100 { width: 100%; }
.bold { font-weight: bold; }
.red { color: red; }
.border {
  border: gray solid 1px;
  border-radius: 0.2em;
  padding: 0.5em;
}

/* specific */

.pool-label { width: 6em; }
.pool-value { width: 2em; text-align: right; padding-right: 0.5em; }
.bar { height: 1.2em; width: fit-content; }

"""


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
                    [ class "flex" ]
                    [ model.characters
                        |> List.sortBy .name
                        |> List.partition (isSelected model)
                        |> (\( myChar, otherChars ) -> myChar ++ otherChars)
                        |> List.map (viewCharacter model)
                        |> div [ class "mr2" ]
                    , viewDisplayCypher model.displayCypher
                    ]
        , node "style"
            []
            [ Html.text css ]
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


viewCharacter : Model -> Character -> Html Msg
viewCharacter model pc =
    div
        []
        [ h3 [] [ text pc.name ]
        , div
            [ class "media-layout"
            ]
            [ img
                [ Html.Attributes.src pc.url
                , class "portrait mr2"
                ]
                []
            , table
                [ class "mr2" ]
                [ viewTier pc.tier
                , viewPoints model Destiny pc
                , viewPoints model Experience pc
                , viewPool model Body pc
                , viewPool model Mind pc
                , viewPool model Essence pc
                ]
            , div
                [ class "border mr1" ]
                [ h3 [] [ text "Recovery" ]
                , List.range 0 3
                    |> List.map (viewRecovery model pc)
                    |> div []
                ]
            , div
                [ class "border" ]
                [ h3 [] [ text "Cyphers" ]
                , pc.cyphers
                    |> List.indexedMap (viewCypher model pc)
                    |> ol []
                ]
            ]
        ]


viewTier : Int -> Html Msg
viewTier t =
    tr []
        [ td [] [ text "Tier" ]
        , td [] [ div [ class "pool-value" ] [ String.fromInt t |> text ] ]
        ]


viewPoints : Model -> Points -> Character -> Html Msg
viewPoints model p char =
    let
        n =
            case p of
                Destiny ->
                    char.dps

                Experience ->
                    char.xps
    in
    tr
        []
        [ td
            []
            [ [ case p of
                    Experience ->
                        "Experience points"

                    Destiny ->
                        "Destiny points"
              ]
                |> String.join " "
                |> text
            ]
        , td
            []
            [ div
                [ class "pool-value" ]
                [ String.fromInt n |> text ]
            ]
        , td
            []
            [ if isSt model then
                button
                    [ onRecklessClick <| TbDeltaPoints char.id p 1
                    , class "w100"
                    ]
                    [ text "Add 1" ]

              else if isSelected model char && n > 0 then
                button
                    [ onRecklessClick <| TbDeltaPoints char.id p -1
                    , class "w100"
                    ]
                    [ text "Use 1" ]

              else
                text ""
            ]
        ]


viewPool : Model -> PoolType -> Character -> Html Msg
viewPool model pt char =
    let
        ( pool, ( committedColor, availableColor, usedColor ) ) =
            case pt of
                Body ->
                    ( char.body
                    , ( "hsl(15,  23%, 30%)"
                      , "hsl(15, 100%, 50%)"
                      , "hsl(15, 100%, 90%)"
                      )
                    )

                Mind ->
                    ( char.mind
                    , ( "hsl(208,  23%, 30%)"
                      , "hsl(208, 100%, 50%)"
                      , "hsl(208, 100%, 90%)"
                      )
                    )

                Essence ->
                    ( char.essence
                    , ( "hsl(54,  23%, 30%)"
                      , "hsl(54, 100%, 50%)"
                      , "hsl(54, 100%, 90%)"
                      )
                    )

        available =
            pool.max - pool.used - pool.committed
    in
    tr
        []
        [ td [] [ div [ class "pool-label" ] [ text <| poolTypeToString pt ] ]
        , td [] [ div [ class "pool-value" ] [ text <| String.fromInt available ] ]
        , td []
            [ if isSelected model char then
                div
                    []
                    [ button [ onRecklessClick <| TbDeltaPool char.id pt 1 ] [ text "-" ]
                    , span [ class "mr1" ] []
                    , button [ onRecklessClick <| TbDeltaPool char.id pt -1 ] [ text "+" ]
                    ]

              else
                text ""
            ]
        , td
            []
            [ div
                [ class "flex bar"
                , style "border" <| usedColor ++ " solid 1px"
                ]
                [ viewBar committedColor "none" pool.committed
                , viewBar availableColor usedColor available
                , viewBar "none" usedColor pool.used
                ]
            ]
        ]


poolTypeToString : PoolType -> String
poolTypeToString pt =
    case pt of
        Body ->
            "Body"

        Mind ->
            "Mind"

        Essence ->
            "Essence"


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
    in
    div []
        [ if isSelected model char then
            button
                [ Html.Attributes.disabled <| not isNext
                , onRecklessClick <| TbRecovery char.id rec
                ]
                [ text name ]

          else
            div
                [ classList [ ( "bold", isNext ) ] ]
                [ text name ]
        ]


viewCypher : Model -> Character -> Int -> CypherInstance -> Html Msg
viewCypher model pc index cypher =
    li
        [ classList [ ( "red", index >= pc.maxCyphers ) ]
        , Html.Events.onMouseEnter <| OnMouseEnterCypher <| Just cypher
        , Html.Events.onMouseLeave <| OnMouseEnterCypher <| Nothing
        ]
        [ if isSelected model pc then
            button [ class "mr1", onRecklessClick <| TbRemoveCypher pc.id index ] [ text "X" ]

          else
            text ""
        , span [] [ text cypher.name ]
        ]


viewDisplayCypher : Maybe CypherInstance -> Html Msg
viewDisplayCypher maybeCypher =
    case maybeCypher of
        Nothing ->
            text ""

        Just c ->
            div
                [ style "flex" "1" ]
                [ h3 [] [ text c.name ]
                , div [] [ text <| "Level: " ++ String.fromInt c.level ]
                , c.info
                    |> String.split "\n"
                    |> List.map (\s -> p [] [ text s ])
                    |> div []
                ]
