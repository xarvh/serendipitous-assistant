module Backend exposing (..)

import Lamdera
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
    ( { characters = [] }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )


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

        TbAddCharacter ->
            let
                id =
                    model.characters
                        |> List.map .id
                        |> List.maximum
                        |> Maybe.withDefault 0
                        |> (+) 1
            in
            { model | characters = initCharacter id :: model.characters }
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
            updateId id (updatePool poolType (\pool -> { pool | used = pool.used + delta })) model
