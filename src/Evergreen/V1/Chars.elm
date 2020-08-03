module Evergreen.V1.Chars exposing (..)

type alias Pool = 
    { max : Int
    , committed : Int
    , used : Int
    }


type alias CypherInstance = 
    { name : String
    , level : Int
    , info : String
    }


type alias Character = 
    { id : Int
    , name : String
    , url : String
    , tier : Int
    , dps : Int
    , xps : Int
    , body : Pool
    , mind : Pool
    , essence : Pool
    , maxCyphers : Int
    , cyphers : (List CypherInstance)
    , nextRecovery : Int
    }


type alias Id = Int


type Points
    = Experience
    | Destiny


type PoolType
    = Body
    | Mind
    | Essence