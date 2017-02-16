module Update exposing (..)

import Counter
import StarWars
import Navigation
import Model exposing (Model)
import Router exposing (getRoute, Route(..))


type Msg
    = NewUrl String
    | UrlChange Navigation.Location
    | CounterMsg Counter.Msg
    | StarWarsMsg StarWars.Msg


setStateForLocation : Navigation.Location -> Model -> Model
setStateForLocation location model =
    let
        newRoute =
            getRoute location

        modelWithNewRoute =
            { model | route = newRoute }
    in
        case newRoute of
            CounterRoute ->
                { modelWithNewRoute | counter = Counter.initialModel }

            StarWarsRoute ->
                { modelWithNewRoute | starWars = StarWars.initialModel }

            _ ->
                modelWithNewRoute


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewUrl url ->
            ( model, Navigation.newUrl url )

        UrlChange location ->
            ( setStateForLocation location model
            , Cmd.none
            )

        CounterMsg subMsg ->
            let
                ( updatedCounter, subCmd ) =
                    Counter.update subMsg model.counter
            in
                ( { model | counter = updatedCounter }
                , Cmd.map CounterMsg subCmd
                )

        StarWarsMsg subMsg ->
            let
                ( updatedStarWars, subCmd ) =
                    StarWars.update subMsg model.starWars
            in
                ( { model | starWars = updatedStarWars }
                , Cmd.map StarWarsMsg subCmd
                )
