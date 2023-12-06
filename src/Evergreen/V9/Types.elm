module Evergreen.V9.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V9.Chars
import Random
import Url


type alias FrontendModel =
    { characters : List Evergreen.V9.Chars.Character
    , edit : String
    , url : Url.Url
    , navKey : Browser.Navigation.Key
    }


type alias BackendModel =
    { characters : List Evergreen.V9.Chars.Character
    , seed : Random.Seed
    }


type ToBackend
    = TbJson (List Evergreen.V9.Chars.Character)
    | TbRequestCharacters
    | TbName Evergreen.V9.Chars.Id String
    | TbDeltaPoints Evergreen.V9.Chars.Id Evergreen.V9.Chars.Points Int
    | TbDeltaPool Evergreen.V9.Chars.Id Evergreen.V9.Chars.PoolType Int
    | TbRecovery Evergreen.V9.Chars.Id Int
    | TbAddCypher Evergreen.V9.Chars.Id
    | TbRemoveCypher Evergreen.V9.Chars.Id Int


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter Evergreen.V9.Chars.Id
    | OnTextareaInput String


type BackendMsg
    = OnInitTime Int


type ToFrontend
    = TfCharacters (List Evergreen.V9.Chars.Character)
