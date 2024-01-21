module Evergreen.V16.Chars exposing (..)


type alias Pool =
    { max : Int
    , committed : Int
    , used : Int
    }


type alias CypherInstance =
    { name : String
    , level : Int
    , info : String
    , used : Bool
    , id : Int
    }


type alias Character =
    { id : Int
    , name : String
    , url : String
    , tier : Int
    , xps : Int
    , might : Pool
    , speed : Pool
    , intellect : Pool
    , maxCyphers : Int
    , cyphers : List CypherInstance
    , nextRecovery : Int
    , extraRecovery : Int
    , pendingRecovery : Int
    , levity : Bool
    }


type alias Id =
    Int


type Points
    = Experience


type PoolType
    = Might
    | Speed
    | Intellect
