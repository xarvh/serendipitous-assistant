module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


noCmd : model -> ( model, Cmd msg )
noCmd model =
    ( model, Cmd.none )


{-| Frontend
-}
type alias FrontendModel =
    { characters : List Character
    , selectedCharacterId : Maybe Id
    , url : Url
    , navKey : Key
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | OnRecklessSend ToBackend
    | OnSelectCharacter (Maybe Id)


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
    = TbAddCharacter
    | TbRequestCharacters
    | TbName Id String
    | TbDeltaPoints Id Points Int
    | TbDeltaPool Id PoolType Int


{-| To Frontend
-}
type ToFrontend
    = TfCharacters (List Character)


{-| Model types
-}
type alias Id =
    Int


type alias Character =
    { id : Int
    , name : String
    , tier : Int
    , dps : Int
    , xps : Int
    , body : Pool
    , mind : Pool
    , essence : Pool
    , maxCyphers : Int
    , cyphers : List Cypher
    , nextRecovery : Int
    }


initCharacter : Id -> Character
initCharacter id =
    { id = id
    , name = ""
    , tier = 1
    , dps = 0
    , xps = 0
    , body = initPool
    , mind = initPool
    , essence = initPool
    , maxCyphers = 2
    , cyphers = []
    , nextRecovery = 0
    }


type alias Pool =
    { max : Int
    , committed : Int
    , used : Int
    }


initPool : Pool
initPool =
    { max = 10
    , committed = 0
    , used = 0
    }


type PoolType
    = Body
    | Mind
    | Essence


type alias Cypher =
    { name : String
    , info : String
    }


type Points
    = Experience
    | Destiny
