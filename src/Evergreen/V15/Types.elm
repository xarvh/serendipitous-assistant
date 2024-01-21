module Evergreen.V15.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V15.Chars
import Random
import Url


type alias FrontendModel =
    { characters : List Evergreen.V15.Chars.Character
    , edit : String
    , url : Url.Url
    , navKey : Browser.Navigation.Key
    }


type alias BackendModel =
    { characters : List Evergreen.V15.Chars.Character
    , seed : Random.Seed
    , nextCypherId : Int
    }


type ToBackend
    = TbJson (List Evergreen.V15.Chars.Character)
    | TbRequestCharacters
    | TbName Evergreen.V15.Chars.Id String
    | TbDeltaPoints Evergreen.V15.Chars.Id Evergreen.V15.Chars.Points Int
    | TbDeltaPool Evergreen.V15.Chars.Id Evergreen.V15.Chars.PoolType Int
    | TbRecovery Evergreen.V15.Chars.Id Int
    | TbAddCypher Evergreen.V15.Chars.Id
    | TbRemoveCypher Evergreen.V15.Chars.Id Int
    | TbGiveCypherTo Evergreen.V15.Chars.Id Int String
    | TbToggleLevity Evergreen.V15.Chars.Id Bool


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter Evergreen.V15.Chars.Id
    | OnTextareaInput String


type BackendMsg
    = OnInitTime Int


type ToFrontend
    = TfCharacters (List Evergreen.V15.Chars.Character)
