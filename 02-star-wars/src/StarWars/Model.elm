module StarWars.Model exposing (..)

import Json.Decode exposing (Decoder, field, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)


type alias SearchResults =
    { count : Int
    , results : List Person
    }


type alias Person =
    { name : String
    , height : String
    , hairColor : String
    , eyeColor : String
    , birthYear : String
    }


type SearchStatus
    = Ready
    | Searching
    | Done


type ViewState
    = Search SearchStatus
    | Detail Person


type alias Model =
    { query : String
    , searchResults : List Person
    , viewState : ViewState
    }


personDecoder : Decoder Person
personDecoder =
    decode Person
        |> required "name" string
        |> required "height" string
        |> required "hair_color" string
        |> required "eye_color" string
        |> required "birth_year" string


searchResultsDecoder : Decoder (List Person)
searchResultsDecoder =
    field "results" (list personDecoder)
