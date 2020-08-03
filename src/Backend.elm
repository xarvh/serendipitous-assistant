module Backend exposing (..)

import Chars exposing (..)
import Lamdera
import Random exposing (Seed)
import Task
import Time
import Types exposing (..)


{-| Main
-}
type alias Model =
    BackendModel


type alias Msg =
    BackendMsg


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = \m -> Sub.none
        }


{-| Tea
-}
init : ( Model, Cmd Msg )
init =
    ( { characters =
            [ { initCharacter | id = 0, name = "Aida" }
            , { initCharacter | id = 1, name = "Emerald" }
            , { initCharacter | id = 2, name = "Goat" }
            , { initCharacter | id = 3, name = "Wolf" }
            ]
      , seed = Random.initialSeed 0
      }
    , Task.perform OnInitTime (Task.map Time.posixToMillis Time.now)
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInitTime millis ->
            ( { model | seed = Random.initialSeed millis }, Cmd.none )


updateId : Id -> (Character -> Character) -> Model -> ( Model, Cmd Msg )
updateId id upd model =
    sendPcs { model | characters = List.map (updateIfId id upd) model.characters }


updatePool : PoolType -> (Pool -> Pool) -> Character -> Character
updatePool pt upd c =
    case pt of
        Body ->
            { c | body = upd c.body }

        Mind ->
            { c | mind = upd c.mind }

        Essence ->
            { c | essence = upd c.essence }


updateIfId : Id -> (Character -> Character) -> Character -> Character
updateIfId id upd c =
    if c.id == id then
        upd c

    else
        c


sendPcs : Model -> ( Model, Cmd Msg )
sendPcs model =
    ( model
    , Lamdera.broadcast <| TfCharacters model.characters
    )


updateFromFrontend : Lamdera.SessionId -> Lamdera.ClientId -> ToBackend -> Model -> ( Model, Cmd Msg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        TbRequestCharacters ->
            sendPcs model

        TbJson pcs ->
            { model | characters = pcs }
                |> sendPcs

        TbName id name ->
            updateId id (\c -> { c | name = name }) model

        TbDeltaPoints id points delta ->
            let
                upd char =
                    case points of
                        Destiny ->
                            { char | dps = char.dps + delta }

                        Experience ->
                            { char | xps = char.xps + delta }
            in
            updateId id upd model

        TbDeltaPool id poolType delta ->
            let
                upd pool =
                    { pool | used = clamp 0 (pool.max - pool.committed) (pool.used + delta) }
            in
            updateId id (updatePool poolType upd) model

        TbRecovery id rec ->
            -- TODO add cypher
            updateId id (\char -> { char | nextRecovery = rec + 1 |> modBy 4 }) model
