module Router exposing (..)

import Maybe exposing (withDefault)
import Navigation exposing (Location)
import UrlParser as Url exposing (map, oneOf, parsePath, s, top, Parser)


type Route
    = HomeRoute
    | CounterRoute
    | StarWarsRoute


parseRoute : Location -> Maybe Route
parseRoute =
    parsePath <|
        oneOf
            [ map HomeRoute top
            , map CounterRoute (s "01-counter")
            , map StarWarsRoute (s "02-star-wars")
            ]


getRoute =
    withDefault HomeRoute << parseRoute
