module Frontend exposing (..)

import Browser
import Browser.Navigation
import Html exposing (..)
import Html.Attributes exposing (class, classList)
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


isSt : Model -> Bool
isSt model =
    model.url.path == "/st"


isEdit : Model -> Bool
isEdit model =
    model.url.path == "/edit"


isSelected : Model -> Character -> Bool
isSelected model char =
    model.selectedCharacterId == Just char.id


{-| Tea
-}
init : Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init url key =
    ( { characters = []
      , selectedCharacterId = Nothing
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
            { model | selectedCharacterId = maybeId }
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
.flex { display: flex; }

.pool-label { width: 6em; }
.pool-value { width: 2em; }
.bar { height: 1em; }

"""


view : Model -> Browser.Document Msg
view model =
    { title = "Serendepitous Assistant"
    , body =
        [ if isEdit model then
            model.characters
                |> List.map (viewCharacterEdit model)
                |> div []

          else if model.selectedCharacterId == Nothing && not (isSt model) then
            viewWhoAreYou model

          else
            model.characters
                |> List.sortBy .name
                |> List.partition (\c -> Just c.id == model.selectedCharacterId)
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
            [ div
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
    div [] [ "Tier: " ++ String.fromInt t |> text ]


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
    div []
        [ [ Debug.toString p
          , "points:"
          , String.fromInt n
          ]
            |> String.join " "
            |> text
        , if isSt model then
            button [ onRecklessClick <| TbDeltaPoints char.id p 1 ] [ text "Add 1" ]

          else if isSelected model char && n > 0 then
            button [ onRecklessClick <| TbDeltaPoints char.id p -1 ] [ text "Use 1" ]

          else
            text ""
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

        viewBar color value =
            if value == 0 then
                text ""

            else
                div
                    [ Html.Attributes.style "width" <| String.fromInt value ++ "em"
                    , Html.Attributes.style "background-color" color
                    , class "bar"
                    ]
                    []
    in
    div
        [ class "flex" ]
        [ span [ class "pool-label" ] [ text <| Debug.toString pt ]
        , span [ class "pool-value" ] [ text <| String.fromInt available ]
        , if isSelected model char then
            div
                []
                [ button [ onRecklessClick <| TbDeltaPool char.id pt 1 ] [ text "-" ]
                , button [ onRecklessClick <| TbDeltaPool char.id pt -1 ] [ text "+" ]
                ]

          else
            text ""
        , viewBar committedColor pool.committed
        , viewBar availableColor available
        , viewBar usedColor pool.used
        ]


viewRecovery : Character -> Html Msg
viewRecovery c =
    div [] []


viewCypher : Int -> Int -> Cypher -> Html Msg
viewCypher max index cypher =
    div [] []
