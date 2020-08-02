module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Chars exposing (..)
import Url exposing (Url)


noCmd : model -> ( model, Cmd msg )
noCmd model =
    ( model, Cmd.none )


{-| Frontend
-}
type alias FrontendModel =
    { characters : List Character
    , edit : String
    , url : Url
    , navKey : Key
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter Id
    | OnTextareaInput String


{-| Backend
-}
type alias BackendModel =
    { characters : List Character
    }


type BackendMsg
    = Noop


{-| To Backend
-}
type ToBackend
    = TbJson (List Character)
    | TbRequestCharacters
    | TbName Id String
    | TbDeltaPoints Id Points Int
    | TbDeltaPool Id PoolType Int


{-| To Frontend
-}
type ToFrontend
    = TfCharacters (List Character)
