module Evergreen.V16.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V16.Chars
import Random
import Url


type alias FrontendModel =
    { characters : List Evergreen.V16.Chars.Character
    , edit : String
    , url : Url.Url
    , navKey : Browser.Navigation.Key
    , allowNotifications : Bool
    }


type alias BackendModel =
    { characters : List Evergreen.V16.Chars.Character
    , seed : Random.Seed
    , nextCypherId : Int
    }


type ToBackend
    = TbJson (List Evergreen.V16.Chars.Character)
    | TbRequestCharacters
    | TbName Evergreen.V16.Chars.Id String
    | TbDeltaPoints Evergreen.V16.Chars.Id Evergreen.V16.Chars.Points Int
    | TbDeltaPool Evergreen.V16.Chars.Id Evergreen.V16.Chars.PoolType Int
    | TbRecovery Evergreen.V16.Chars.Id Int
    | TbAddCypher Evergreen.V16.Chars.Id
    | TbRemoveCypher Evergreen.V16.Chars.Id Int
    | TbGiveCypherTo Evergreen.V16.Chars.Id Int String
    | TbToggleLevity Evergreen.V16.Chars.Id Bool


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter Evergreen.V16.Chars.Id
    | OnTextareaInput String
    | OnAllowNotifications


type BackendMsg
    = OnInitTime Int


type ToFrontend
    = TfCharacters (List Evergreen.V16.Chars.Character)
