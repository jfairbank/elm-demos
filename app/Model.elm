module Model exposing (..)

import Counter
import StarWars
import Router exposing (Route)


type alias Model =
    { counter : Counter.Model
    , starWars : StarWars.Model
    , route : Route
    }
