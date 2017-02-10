module Router exposing (..)

import Maybe exposing (withDefault)
import Navigation exposing (Location)
import UrlParser as Url exposing (map, oneOf, parsePath, s, top, Parser)


type Route
    = HomeRoute
    | CounterRoute
    | VotingRoute


route : Parser (Route -> a) a
route =
    oneOf
        [ map HomeRoute top
        , map CounterRoute (s "01-counter")
        , map VotingRoute (s "02-voting")
        ]


getRoute : Location -> Route
getRoute =
    parsePath route >> withDefault HomeRoute
