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
    , dps : Int
    , xps : Int
    , body : Pool
    , mind : Pool
    , essence : Pool
    , maxCyphers : Int
    , cyphers : List CypherInstance
    , nextRecovery : Int
    }


initCharacter : Character
initCharacter =
    { id = 0
    , name = ""
    , url = ""
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


characterDecoder : Decoder Character
characterDecoder =
    Json.Decode.succeed Character
        |> required "id" Json.Decode.int
        |> required "name" Json.Decode.string
        |> required "url" Json.Decode.string
        |> required "tier" Json.Decode.int
        |> required "dps" Json.Decode.int
        |> required "xps" Json.Decode.int
        |> required "body" poolDecoder
        |> required "mind" poolDecoder
        |> required "essence" poolDecoder
        |> required "maxCyphers" Json.Decode.int
        |> required "cyphers" (Json.Decode.list cypherDecoder)
        |> required "nextRecovery" Json.Decode.int


encodeCharacter : Character -> Json.Encode.Value
encodeCharacter c =
    Json.Encode.object
        [ ( "id", Json.Encode.int c.id )
        , ( "name", Json.Encode.string c.name )
        , ( "url", Json.Encode.string c.url )
        , ( "tier", Json.Encode.int c.tier )
        , ( "dps", Json.Encode.int c.dps )
        , ( "xps", Json.Encode.int c.xps )
        , ( "body", encodePool c.body )
        , ( "mind", encodePool c.mind )
        , ( "essence", encodePool c.essence )
        , ( "maxCyphers", Json.Encode.int c.maxCyphers )
        , ( "cyphers", Json.Encode.list encodeCypher c.cyphers )
        , ( "nextRecovery", Json.Encode.int c.nextRecovery )
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
    = Body
    | Mind
    | Essence


type alias CypherInstance =
    { name : String
    , level : Int
    , info : String
    }


cypherDecoder : Decoder CypherInstance
cypherDecoder =
    Json.Decode.succeed CypherInstance
        |> required "name" Json.Decode.string
        |> required "level" Json.Decode.int
        |> required "info" Json.Decode.string


encodeCypher : CypherInstance -> Json.Encode.Value
encodeCypher c =
    Json.Encode.object
        [ ( "name", Json.Encode.string c.name )
        , ( "level", Json.Encode.int c.level )
        , ( "info", Json.Encode.string c.info )
        ]


type Points
    = Experience
    | Destiny
