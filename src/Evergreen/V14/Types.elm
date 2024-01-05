module Evergreen.V14.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V14.Chars
import Random
import Url


type alias FrontendModel =
    { characters : List Evergreen.V14.Chars.Character
    , edit : String
    , url : Url.Url
    , navKey : Browser.Navigation.Key
    }


type alias BackendModel =
    { characters : List Evergreen.V14.Chars.Character
    , seed : Random.Seed
    }


type ToBackend
    = TbJson (List Evergreen.V14.Chars.Character)
    | TbRequestCharacters
    | TbName Evergreen.V14.Chars.Id String
    | TbDeltaPoints Evergreen.V14.Chars.Id Evergreen.V14.Chars.Points Int
    | TbDeltaPool Evergreen.V14.Chars.Id Evergreen.V14.Chars.PoolType Int
    | TbRecovery Evergreen.V14.Chars.Id Int
    | TbAddCypher Evergreen.V14.Chars.Id
    | TbRemoveCypher Evergreen.V14.Chars.Id Int
    | TbToggleLevity Evergreen.V14.Chars.Id Bool


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter Evergreen.V14.Chars.Id
    | OnTextareaInput String


type BackendMsg
    = OnInitTime Int


type ToFrontend
    = TfCharacters (List Evergreen.V14.Chars.Character)
