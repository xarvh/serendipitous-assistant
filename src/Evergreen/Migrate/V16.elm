module Evergreen.Migrate.V16 exposing (..)

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

import Evergreen.V15.Chars
import Evergreen.V15.Types
import Evergreen.V16.Chars
import Evergreen.V16.Types
import Lamdera.Migrations exposing (..)


frontendModel : Evergreen.V15.Types.FrontendModel -> ModelMigration Evergreen.V16.Types.FrontendModel Evergreen.V16.Types.FrontendMsg
frontendModel old =
    ModelMigrated ( migrate_Types_FrontendModel old, Cmd.none )


backendModel : Evergreen.V15.Types.BackendModel -> ModelMigration Evergreen.V16.Types.BackendModel Evergreen.V16.Types.BackendMsg
backendModel old =
    ModelUnchanged


frontendMsg : Evergreen.V15.Types.FrontendMsg -> MsgMigration Evergreen.V16.Types.FrontendMsg Evergreen.V16.Types.FrontendMsg
frontendMsg old =
    MsgMigrated ( migrate_Types_FrontendMsg old, Cmd.none )


toBackend : Evergreen.V15.Types.ToBackend -> MsgMigration Evergreen.V16.Types.ToBackend Evergreen.V16.Types.BackendMsg
toBackend old =
    MsgUnchanged


backendMsg : Evergreen.V15.Types.BackendMsg -> MsgMigration Evergreen.V16.Types.BackendMsg Evergreen.V16.Types.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Evergreen.V15.Types.ToFrontend -> MsgMigration Evergreen.V16.Types.ToFrontend Evergreen.V16.Types.FrontendMsg
toFrontend old =
    MsgUnchanged


migrate_Types_FrontendModel : Evergreen.V15.Types.FrontendModel -> Evergreen.V16.Types.FrontendModel
migrate_Types_FrontendModel old =
    { characters = old.characters
    , edit = old.edit
    , url = old.url
    , navKey = old.navKey
    , allowNotifications = False
    }


migrate_Chars_Points : Evergreen.V15.Chars.Points -> Evergreen.V16.Chars.Points
migrate_Chars_Points old =
    case old of
        Evergreen.V15.Chars.Experience ->
            Evergreen.V16.Chars.Experience


migrate_Chars_PoolType : Evergreen.V15.Chars.PoolType -> Evergreen.V16.Chars.PoolType
migrate_Chars_PoolType old =
    case old of
        Evergreen.V15.Chars.Might ->
            Evergreen.V16.Chars.Might

        Evergreen.V15.Chars.Speed ->
            Evergreen.V16.Chars.Speed

        Evergreen.V15.Chars.Intellect ->
            Evergreen.V16.Chars.Intellect


migrate_Types_FrontendMsg : Evergreen.V15.Types.FrontendMsg -> Evergreen.V16.Types.FrontendMsg
migrate_Types_FrontendMsg old =
    case old of
        Evergreen.V15.Types.UrlClicked p0 ->
            Evergreen.V16.Types.UrlClicked p0

        Evergreen.V15.Types.UrlChanged p0 ->
            Evergreen.V16.Types.UrlChanged p0

        Evergreen.V15.Types.OnRecklessSend p0 ->
            Evergreen.V16.Types.OnRecklessSend (p0 |> migrate_Types_ToBackend)

        Evergreen.V15.Types.OnSelectCharacter p0 ->
            Evergreen.V16.Types.OnSelectCharacter p0

        Evergreen.V15.Types.OnTextareaInput p0 ->
            Evergreen.V16.Types.OnTextareaInput p0


migrate_Types_ToBackend : Evergreen.V15.Types.ToBackend -> Evergreen.V16.Types.ToBackend
migrate_Types_ToBackend old =
    case old of
        Evergreen.V15.Types.TbJson p0 ->
            Evergreen.V16.Types.TbJson p0

        Evergreen.V15.Types.TbRequestCharacters ->
            Evergreen.V16.Types.TbRequestCharacters

        Evergreen.V15.Types.TbName p0 p1 ->
            Evergreen.V16.Types.TbName p0 p1

        Evergreen.V15.Types.TbDeltaPoints p0 p1 p2 ->
            Evergreen.V16.Types.TbDeltaPoints p0 (p1 |> migrate_Chars_Points) p2

        Evergreen.V15.Types.TbDeltaPool p0 p1 p2 ->
            Evergreen.V16.Types.TbDeltaPool p0 (p1 |> migrate_Chars_PoolType) p2

        Evergreen.V15.Types.TbRecovery p0 p1 ->
            Evergreen.V16.Types.TbRecovery p0 p1

        Evergreen.V15.Types.TbAddCypher p0 ->
            Evergreen.V16.Types.TbAddCypher p0

        Evergreen.V15.Types.TbRemoveCypher p0 p1 ->
            Evergreen.V16.Types.TbRemoveCypher p0 p1

        Evergreen.V15.Types.TbGiveCypherTo p0 p1 p2 ->
            Evergreen.V16.Types.TbGiveCypherTo p0 p1 p2

        Evergreen.V15.Types.TbToggleLevity p0 p1 ->
            Evergreen.V16.Types.TbToggleLevity p0 p1