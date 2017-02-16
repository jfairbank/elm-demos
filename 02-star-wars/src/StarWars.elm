module StarWars exposing (..)

import Html exposing (Html, a, button, h2, input, div, label, li, text, ul)
import StarWars.Model exposing (SearchStatus(..), ViewState(..))
import StarWars.View
import StarWars.Update


type alias Model =
    StarWars.Model.Model


type alias Msg =
    StarWars.Update.Msg


initialModel : Model
initialModel =
    StarWars.Model.Model "" [] (Search Ready)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


view : Model -> Html Msg
view =
    StarWars.View.view


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    StarWars.Update.update


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
