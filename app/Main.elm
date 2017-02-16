module Main exposing (..)

import Counter
import StarWars
import Navigation
import Router exposing (getRoute)
import Model exposing (Model)
import View exposing (..)
import Update exposing (..)


initialModel : Navigation.Location -> Model
initialModel location =
    Model Counter.initialModel StarWars.initialModel (getRoute location)


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( initialModel location, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
