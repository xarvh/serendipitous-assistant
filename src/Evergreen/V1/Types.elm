module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Evergreen.V1.Chars
import Random
import Url


type alias FrontendModel =
    { characters : List Evergreen.V1.Chars.Character
    , edit : String
    , url : Url.Url
    , navKey : Browser.Navigation.Key
    }


type alias BackendModel =
    { characters : List Evergreen.V1.Chars.Character
    , seed : Random.Seed
    }


type ToBackend
    = TbJson (List Evergreen.V1.Chars.Character)
    | TbRequestCharacters
    | TbName Evergreen.V1.Chars.Id String
    | TbDeltaPoints Evergreen.V1.Chars.Id Evergreen.V1.Chars.Points Int
    | TbDeltaPool Evergreen.V1.Chars.Id Evergreen.V1.Chars.PoolType Int
    | TbRecovery Evergreen.V1.Chars.Id Int
    | TbRemoveCypher Evergreen.V1.Chars.Id Int


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter Evergreen.V1.Chars.Id
    | OnTextareaInput String


type BackendMsg
    = OnInitTime Int


type ToFrontend
    = TfCharacters (List Evergreen.V1.Chars.Character)
