module Backend exposing (..)

import Chars exposing (..)
import Cyphers exposing (CypherType, Roll)
import Lamdera
import List.Extra
import Random exposing (Generator)
import Random.Extra
import Random.List
import Task
import Time
import Types exposing (..)


when : Bool -> (a -> a) -> a -> a
when test upd a =
    if test then
        upd a

    else
        a


findBy : (a -> id) -> id -> List a -> Maybe a
findBy getId id =
    List.Extra.find (\a -> getId a == id)


removeBy : (a -> id) -> id -> List a -> List a
removeBy getId id =
    List.filter (\a -> getId a /= id)


updateBy : (a -> id) -> id -> (a -> a) -> List a -> List a
updateBy getId id upd =
    let
        f a =
            if getId a == id then
                upd a

            else
                a
    in
    List.map f


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
            ]
      , seed = Random.initialSeed 0
      , nextCypherId = 0
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
    sendPcs { model | characters = updateBy .id id upd model.characters }


updatePool : PoolType -> (Pool -> Pool) -> Character -> Character
updatePool pt upd c =
    case pt of
        Might ->
            { c | might = upd c.might }

        Speed ->
            { c | speed = upd c.speed }

        Intellect ->
            { c | intellect = upd c.intellect }


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
                        Experience ->
                            { char | xps = char.xps + delta }
            in
            updateId id upd model

        TbDeltaPool id poolType delta ->
            let
                upd pool =
                    { pool | used = clamp 0 (pool.max - pool.committed) (pool.used - delta) }

                updateRecovery char =
                    if delta > 0 then
                        { char | pendingRecovery = max 0 (char.pendingRecovery - delta) }

                    else
                        char
            in
            updateId id (updateRecovery >> updatePool poolType upd) model

        TbRecovery id rec ->
            let
                ( d6, seed1 ) =
                    Random.step (Random.int 1 6) model.seed
            in
            { model | seed = seed1 }
                -- TODO clean up, should not be discarding the Cmd
                |> when (recoveryGivesCypher rec) (newCypherToCharacter id >> Tuple.first)
                |> updateId id
                    (\char ->
                        (if rec == -1 then
                            char

                         else
                            { char | nextRecovery = rec + 1 |> modBy 4 }
                        )
                            |> maybeAddRecovery d6
                    )

        TbAddCypher id ->
            newCypherToCharacter id model

        TbRemoveCypher charId cypherId ->
            updateId charId (\char -> { char | cyphers = useOrRemoveCypher cypherId char.cyphers }) model

        TbGiveCypherTo fromCharacterId cypherId toCharacterIdString ->
            let
                maybeCharacter =
                    findBy .id fromCharacterId model.characters

                maybeCypher =
                    Maybe.andThen (\c -> findBy .id cypherId c.cyphers) maybeCharacter

                maybeToCharacterId =
                    String.toInt toCharacterIdString
            in
            case ( maybeCypher, maybeToCharacterId ) of
                ( Just cypher, Just toCharacterId ) ->
                    { model
                        | characters =
                            model.characters
                                |> updateBy .id fromCharacterId (\char -> { char | cyphers = removeBy .id cypherId char.cyphers })
                                |> updateBy .id toCharacterId (\char -> { char | cyphers = cypher :: char.cyphers })
                    }
                        |> sendPcs

                _ ->
                    noCmd model

        TbToggleLevity id levity ->
            updateId id (\char -> { char | levity = levity }) model


newCypherToCharacter : Id -> Model -> ( Model, Cmd Msg )
newCypherToCharacter id model =
    let
        ( cypherNoId, seed1 ) =
            Random.step cypherGenerator model.seed

        cypher =
            { cypherNoId | id = model.nextCypherId }
    in
    { model | seed = seed1, nextCypherId = cypher.id + 1 }
        |> updateId id (\char -> { char | cyphers = char.cyphers ++ [ cypher ] })


recoveryGivesCypher : Int -> Bool
recoveryGivesCypher recoveryId =
    recoveryId == 2 || recoveryId == 3


maybeAddRecovery : Int -> Character -> Character
maybeAddRecovery d6 char =
    let
        totalRecoverable =
            d6 + Chars.baseRecovery char + char.pendingRecovery

        resetPool pool =
            { pool | used = 0 }
    in
    if char.might.used + char.speed.used + char.intellect.used > totalRecoverable then
        { char | pendingRecovery = totalRecoverable }

    else
        { char
            | pendingRecovery = 0
            , might = resetPool char.might
            , speed = resetPool char.speed
            , intellect = resetPool char.intellect
        }


useOrRemoveCypher : Id -> List CypherInstance -> List CypherInstance
useOrRemoveCypher cypherId l =
    case findBy .id cypherId l of
        Nothing ->
            l

        Just cypher ->
            if cypher.used then
                removeBy .id cypherId l

            else
                updateBy .id cypherId (\c -> { c | used = True }) l



-- Cyphers


cypherGenerator : Generator CypherInstance
cypherGenerator =
    Random.List.choose Cyphers.list
        |> Random.andThen (Tuple.first >> cypherTypeToInstanceGenerator)


cypherTypeToInstanceGenerator : Maybe CypherType -> Generator CypherInstance
cypherTypeToInstanceGenerator maybeType =
    case maybeType of
        Nothing ->
            Random.constant
                { name = "Error"
                , level = 0
                , info = "Some list was empty"
                , used = True
                , id = -1
                }

        Just t ->
            Random.map2 (makeCypher t)
                (Random.int 1 6)
                (t.rolls
                    |> List.map rollToGenerator
                    |> Random.Extra.combine
                )


makeCypher : CypherType -> Int -> List String -> CypherInstance
makeCypher t d6 rollEffects =
    { name = String.left 1 t.name ++ String.dropLeft 1 (String.toLower t.name)
    , level = d6 + t.levelModifier
    , info =
        rollEffects
            |> (::) t.description
            |> String.join "\n"
    , used = False
    , id = -1
    }


rollToGenerator : Cyphers.Roll -> Generator String
rollToGenerator roll =
    roll.options
        |> List.map (\option -> ( toFloat option.weight, Random.constant option.effect ))
        |> Random.Extra.frequency ( 0, Random.constant "" )
        |> Random.map (\effect -> roll.name ++ ": " ++ effect)
