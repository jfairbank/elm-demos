module Main exposing (..)

import Counter exposing (..)
import Html exposing (program)


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
