module Evergreen.V7.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V7.Chars
import Random
import Url


type alias FrontendModel =
    { characters : List Evergreen.V7.Chars.Character
    , edit : String
    , url : Url.Url
    , navKey : Browser.Navigation.Key
    }


type alias BackendModel =
    { characters : List Evergreen.V7.Chars.Character
    , seed : Random.Seed
    }


type ToBackend
    = TbJson (List Evergreen.V7.Chars.Character)
    | TbRequestCharacters
    | TbName Evergreen.V7.Chars.Id String
    | TbDeltaPoints Evergreen.V7.Chars.Id Evergreen.V7.Chars.Points Int
    | TbDeltaPool Evergreen.V7.Chars.Id Evergreen.V7.Chars.PoolType Int
    | TbRecovery Evergreen.V7.Chars.Id Int
    | TbAddCypher Evergreen.V7.Chars.Id
    | TbRemoveCypher Evergreen.V7.Chars.Id Int


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter Evergreen.V7.Chars.Id
    | OnTextareaInput String


type BackendMsg
    = OnInitTime Int


type ToFrontend
    = TfCharacters (List Evergreen.V7.Chars.Character)
