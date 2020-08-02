module Frontend exposing (..)

import Browser
import Browser.Navigation
import Html exposing (..)
import Html.Attributes exposing (class, classList, style)
import Html.Events exposing (onClick)
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
      , url = url
      , navKey = key
      }
    , Lamdera.sendToBackend TbRequestCharacters
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChanged url ->
            ( model, Cmd.none )

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

        OnSelectCharacter maybeId ->
            -- TODO
            model
                |> noCmd


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd Msg )
updateFromBackend msg model =
    case msg of
        TfCharacters pcs ->
            { model | characters = pcs }
                |> noCmd



-- View


css =
    """
body {
  background-color: black;
  color: white;
}

.flex { display: flex; }

.pool-label { width: 6em; }
.pool-value { width: 2em; }
.bar { height: 1.2em; width: fit-content; }

"""


view : Model -> Browser.Document Msg
view model =
    { title = "Serendepitous Assistant"
    , body =
        [ case page model of
            PageEdit ->
                model.characters
                    |> List.map (viewCharacterEdit model)
                    |> div []

            PagePick ->
                viewWhoAreYou model

            _ ->
                model.characters
                    |> List.sortBy .name
                    |> List.partition (isSelected model)
                    |> (\( myChar, otherChars ) -> myChar ++ otherChars)
                    |> List.map (viewCharacter model)
                    |> div []
        , if isEdit model then
            viewAddCharacter

          else
            text ""
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
            |> List.map (\c -> button [ onClick <| OnSelectCharacter <| Just c.id ] [ text c.name ])
            |> div []
        ]


viewAddCharacter : Html Msg
viewAddCharacter =
    div
        []
        [ button
            [ onRecklessClick TbAddCharacter ]
            [ text "Add character" ]
        ]


onRecklessClick : ToBackend -> Html.Attribute Msg
onRecklessClick tb =
    onClick <| OnRecklessSend tb



-- View edit


viewCharacterEdit : Model -> Character -> Html Msg
viewCharacterEdit model pc =
    div
        []
        [ input
            [ Html.Events.onInput <| OnRecklessSend << TbName pc.id
            , Html.Attributes.value pc.name
            ]
            []
        ]



-- View character


viewCharacter : Model -> Character -> Html Msg
viewCharacter model pc =
    div
        []
        [ h3 [] [ text pc.name ]
        , div
            []
            [ table
                []
                [ viewTier pc.tier
                , viewPoints model Destiny pc
                , viewPoints model Experience pc
                , viewPool model Body pc
                , viewPool model Mind pc
                , viewPool model Essence pc
                , viewRecovery pc
                ]
            , pc.cyphers
                |> List.indexedMap (viewCypher pc.maxCyphers)
                |> div []
            ]
        ]


viewTier : Int -> Html Msg
viewTier t =
    tr []
        [ td [] [ text "Tier" ]
        , td [] [ String.fromInt t |> text ]
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
            [ [ Debug.toString p
              , "points"
              ]
                |> String.join " "
                |> text
            ]
        , td
            []
            [ String.fromInt n |> text ]
        , td
            []
            [ if isSt model then
                button [ onRecklessClick <| TbDeltaPoints char.id p 1 ] [ text "Add 1" ]

              else if isSelected model char && n > 0 then
                button [ onRecklessClick <| TbDeltaPoints char.id p -1 ] [ text "Use 1" ]

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
                    , ( "grey"
                      , "hsl(15, 100%, 50%)"
                      , "hsl(15, 100%, 90%)"
                      )
                    )

                Mind ->
                    ( char.mind
                    , ( "grey"
                      , "hsl(208, 100%, 50%)"
                      , "hsl(208, 100%, 90%)"
                      )
                    )

                Essence ->
                    ( char.essence
                    , ( "grey"
                      , "hsl(54, 100%, 50%)"
                      , "hsl(54, 100%, 90%)"
                      )
                    )

        available =
            pool.max - pool.used - pool.committed
    in
    tr
        []
        [ td [] [ span [ class "pool-label" ] [ text <| Debug.toString pt ] ]
        , td [] [ span [ class "pool-value" ] [ text <| String.fromInt available ] ]
        , td []
            [ if isSelected model char then
                div
                    []
                    [ button [ onRecklessClick <| TbDeltaPool char.id pt 1 ] [ text "-" ]
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


viewRecovery : Character -> Html Msg
viewRecovery c =
    div [] []


viewCypher : Int -> Int -> Cypher -> Html Msg
viewCypher max index cypher =
    div [] []
