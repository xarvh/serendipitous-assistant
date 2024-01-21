module Chars exposing (..)

import Json.Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)
import Json.Encode


{-| Model types
-}
type alias Id =
    Int


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


initCharacter : Character
initCharacter =
    { id = 0
    , name = ""
    , url = ""
    , tier = 1
    , xps = 0
    , might = initPool
    , speed = initPool
    , intellect = initPool
    , maxCyphers = 2
    , cyphers = []
    , nextRecovery = 0
    , extraRecovery = 0
    , pendingRecovery = 0
    , levity = False
    }


baseRecovery : Character -> Int
baseRecovery char =
    if char.levity then
        char.tier + char.extraRecovery + 1

    else
        char.tier + char.extraRecovery


characterDecoder : Decoder Character
characterDecoder =
    Json.Decode.succeed Character
        |> required "id" Json.Decode.int
        |> required "name" Json.Decode.string
        |> required "url" Json.Decode.string
        |> required "tier" Json.Decode.int
        |> required "xps" Json.Decode.int
        |> required "might" poolDecoder
        |> required "speed" poolDecoder
        |> required "intellect" poolDecoder
        |> required "maxCyphers" Json.Decode.int
        |> required "cyphers" (Json.Decode.list cypherDecoder)
        |> required "nextRecovery" Json.Decode.int
        |> required "extraRecovery" Json.Decode.int
        |> required "pendingRecovery" Json.Decode.int
        |> required "levity" Json.Decode.bool


encodeCharacter : Character -> Json.Encode.Value
encodeCharacter c =
    Json.Encode.object
        [ ( "id", Json.Encode.int c.id )
        , ( "name", Json.Encode.string c.name )
        , ( "url", Json.Encode.string c.url )
        , ( "tier", Json.Encode.int c.tier )
        , ( "xps", Json.Encode.int c.xps )
        , ( "might", encodePool c.might )
        , ( "speed", encodePool c.speed )
        , ( "intellect", encodePool c.intellect )
        , ( "maxCyphers", Json.Encode.int c.maxCyphers )
        , ( "cyphers", Json.Encode.list encodeCypher c.cyphers )
        , ( "nextRecovery", Json.Encode.int c.nextRecovery )
        , ( "extraRecovery", Json.Encode.int c.extraRecovery )
        , ( "pendingRecovery", Json.Encode.int c.pendingRecovery )
        , ( "levity", Json.Encode.bool c.levity )
        ]


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


poolDecoder : Decoder Pool
poolDecoder =
    Json.Decode.succeed Pool
        |> required "max" Json.Decode.int
        |> required "committed" Json.Decode.int
        |> required "used" Json.Decode.int


encodePool : Pool -> Json.Encode.Value
encodePool c =
    Json.Encode.object
        [ ( "max", Json.Encode.int c.max )
        , ( "committed", Json.Encode.int c.committed )
        , ( "used", Json.Encode.int c.used )
        ]


type PoolType
    = Might
    | Speed
    | Intellect


type alias CypherInstance =
    { name : String
    , level : Int
    , info : String
    , used : Bool
    , id : Int
    }


cypherDecoder : Decoder CypherInstance
cypherDecoder =
    Json.Decode.succeed CypherInstance
        |> required "name" Json.Decode.string
        |> required "level" Json.Decode.int
        |> required "info" Json.Decode.string
        |> required "used" Json.Decode.bool
        |> required "id" Json.Decode.int


encodeCypher : CypherInstance -> Json.Encode.Value
encodeCypher c =
    Json.Encode.object
        [ ( "name", Json.Encode.string c.name )
        , ( "level", Json.Encode.int c.level )
        , ( "info", Json.Encode.string c.info )
        , ( "used", Json.Encode.bool c.used )
        , ( "id", Json.Encode.int c.id )
        ]


type Points
    = Experience
