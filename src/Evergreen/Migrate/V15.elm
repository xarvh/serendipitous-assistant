module Evergreen.Migrate.V15 exposing (..)

{-| This migration file was automatically generated by the lamdera compiler.

It includes:

  - A migration for each of the 6 Lamdera core types that has changed
  - A function named `migrate_ModuleName_TypeName` for each changed/custom type

Expect to see:

  - `Unimplementеd` values as placeholders wherever I was unable to figure out a clear migration path for you
  - `@NOTICE` comments for things you should know about, i.e. new custom type constructors that won't get any
    value mappings from the old type by default

You can edit this file however you wish! It won't be generated again.

See <https://dashboard.lamdera.app/docs/evergreen> for more info.

-}

import Evergreen.V14.Chars
import Evergreen.V14.Types
import Evergreen.V15.Chars
import Evergreen.V15.Types
import Lamdera.Migrations exposing (..)
import List


frontendModel : Evergreen.V14.Types.FrontendModel -> ModelMigration Evergreen.V15.Types.FrontendModel Evergreen.V15.Types.FrontendMsg
frontendModel old =
    ModelMigrated ( migrate_Types_FrontendModel old, Cmd.none )


backendModel : Evergreen.V14.Types.BackendModel -> ModelMigration Evergreen.V15.Types.BackendModel Evergreen.V15.Types.BackendMsg
backendModel old =
    ModelMigrated ( migrate_Types_BackendModel old, Cmd.none )


frontendMsg : Evergreen.V14.Types.FrontendMsg -> MsgMigration Evergreen.V15.Types.FrontendMsg Evergreen.V15.Types.FrontendMsg
frontendMsg old =
    MsgMigrated ( migrate_Types_FrontendMsg old, Cmd.none )


toBackend : Evergreen.V14.Types.ToBackend -> MsgMigration Evergreen.V15.Types.ToBackend Evergreen.V15.Types.BackendMsg
toBackend old =
    MsgMigrated ( migrate_Types_ToBackend old, Cmd.none )


backendMsg : Evergreen.V14.Types.BackendMsg -> MsgMigration Evergreen.V15.Types.BackendMsg Evergreen.V15.Types.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Evergreen.V14.Types.ToFrontend -> MsgMigration Evergreen.V15.Types.ToFrontend Evergreen.V15.Types.FrontendMsg
toFrontend old =
    MsgMigrated ( migrate_Types_ToFrontend old, Cmd.none )


migrate_Types_BackendModel : Evergreen.V14.Types.BackendModel -> Evergreen.V15.Types.BackendModel
migrate_Types_BackendModel old =
    { characters = old.characters |> List.map migrate_Chars_Character
    , seed = old.seed
    , nextCypherId = 1000
    }


migrate_Types_FrontendModel : Evergreen.V14.Types.FrontendModel -> Evergreen.V15.Types.FrontendModel
migrate_Types_FrontendModel old =
    { characters = old.characters |> List.map migrate_Chars_Character
    , edit = old.edit
    , url = old.url
    , navKey = old.navKey
    }


migrate_Chars_Character : Evergreen.V14.Chars.Character -> Evergreen.V15.Chars.Character
migrate_Chars_Character old =
    { id = old.id
    , name = old.name
    , url = old.url
    , tier = old.tier
    , xps = old.xps
    , might = old.might |> migrate_Chars_Pool
    , speed = old.speed |> migrate_Chars_Pool
    , intellect = old.intellect |> migrate_Chars_Pool
    , maxCyphers = old.maxCyphers
    , cyphers = old.cyphers |> List.indexedMap (migrate_Chars_CypherInstance old.id)
    , nextRecovery = old.nextRecovery
    , extraRecovery = old.extraRecovery
    , pendingRecovery = old.pendingRecovery
    , levity = old.levity
    }


migrate_Chars_CypherInstance : Int -> Int -> Evergreen.V14.Chars.CypherInstance -> Evergreen.V15.Chars.CypherInstance
migrate_Chars_CypherInstance charId cypherIndex old =
    { name = old.name
    , level = old.level
    , info = old.info
    , used = old.used
    , id = charId * 10 + cypherIndex
    }


migrate_Chars_Points : Evergreen.V14.Chars.Points -> Evergreen.V15.Chars.Points
migrate_Chars_Points old =
    case old of
        Evergreen.V14.Chars.Experience ->
            Evergreen.V15.Chars.Experience


migrate_Chars_Pool : Evergreen.V14.Chars.Pool -> Evergreen.V15.Chars.Pool
migrate_Chars_Pool old =
    old


migrate_Chars_PoolType : Evergreen.V14.Chars.PoolType -> Evergreen.V15.Chars.PoolType
migrate_Chars_PoolType old =
    case old of
        Evergreen.V14.Chars.Might ->
            Evergreen.V15.Chars.Might

        Evergreen.V14.Chars.Speed ->
            Evergreen.V15.Chars.Speed

        Evergreen.V14.Chars.Intellect ->
            Evergreen.V15.Chars.Intellect


migrate_Types_FrontendMsg : Evergreen.V14.Types.FrontendMsg -> Evergreen.V15.Types.FrontendMsg
migrate_Types_FrontendMsg old =
    case old of
        Evergreen.V14.Types.UrlClicked p0 ->
            Evergreen.V15.Types.UrlClicked p0

        Evergreen.V14.Types.UrlChanged p0 ->
            Evergreen.V15.Types.UrlChanged p0

        Evergreen.V14.Types.OnRecklessSend p0 ->
            Evergreen.V15.Types.OnRecklessSend (p0 |> migrate_Types_ToBackend)

        Evergreen.V14.Types.OnSelectCharacter p0 ->
            Evergreen.V15.Types.OnSelectCharacter p0

        Evergreen.V14.Types.OnTextareaInput p0 ->
            Evergreen.V15.Types.OnTextareaInput p0


migrate_Types_ToBackend : Evergreen.V14.Types.ToBackend -> Evergreen.V15.Types.ToBackend
migrate_Types_ToBackend old =
    case old of
        Evergreen.V14.Types.TbJson p0 ->
            Evergreen.V15.Types.TbJson (p0 |> List.map migrate_Chars_Character)

        Evergreen.V14.Types.TbRequestCharacters ->
            Evergreen.V15.Types.TbRequestCharacters

        Evergreen.V14.Types.TbName p0 p1 ->
            Evergreen.V15.Types.TbName p0 p1

        Evergreen.V14.Types.TbDeltaPoints p0 p1 p2 ->
            Evergreen.V15.Types.TbDeltaPoints p0 (p1 |> migrate_Chars_Points) p2

        Evergreen.V14.Types.TbDeltaPool p0 p1 p2 ->
            Evergreen.V15.Types.TbDeltaPool p0 (p1 |> migrate_Chars_PoolType) p2

        Evergreen.V14.Types.TbRecovery p0 p1 ->
            Evergreen.V15.Types.TbRecovery p0 p1

        Evergreen.V14.Types.TbAddCypher p0 ->
            Evergreen.V15.Types.TbAddCypher p0

        Evergreen.V14.Types.TbRemoveCypher p0 p1 ->
            Evergreen.V15.Types.TbRemoveCypher p0 p1

        Evergreen.V14.Types.TbToggleLevity p0 p1 ->
            Evergreen.V15.Types.TbToggleLevity p0 p1


migrate_Types_ToFrontend : Evergreen.V14.Types.ToFrontend -> Evergreen.V15.Types.ToFrontend
migrate_Types_ToFrontend old =
    case old of
        Evergreen.V14.Types.TfCharacters p0 ->
            Evergreen.V15.Types.TfCharacters (p0 |> List.map migrate_Chars_Character)
