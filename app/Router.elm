module Router exposing (..)

import Navigation
import Maybe exposing (withDefault)
import UrlParser as Url exposing (s, top)


type Route
    = HomeRoute
    | CounterRoute
    | VotingRoute


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map HomeRoute top
        , Url.map CounterRoute (s "01-counter")
        , Url.map VotingRoute (s "02-voting")
        ]


getRoute : Navigation.Location -> Route
getRoute =
    Url.parsePath route >> withDefault HomeRoute
