module Main exposing (..)

import Counter
import Voting
import Navigation
import Html exposing (a, div, h1, h4, i, li, nav, text, ul, Html)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Maybe exposing (withDefault)
import UrlParser as Url exposing (s, top)


type Route
    = HomeRoute
    | CounterRoute
    | VotingRoute


type alias Model =
    { counter : Counter.Model
    , voting : Voting.Model
    , route : Route
    }


type Msg
    = NewUrl String
    | UrlChange Navigation.Location
    | CounterMsg Counter.Msg
    | VotingMsg Voting.Msg


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


initialModel : Navigation.Location -> Model
initialModel =
    getRoute
        >> Model Counter.initialModel Voting.initialModel


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( initialModel location, Cmd.none )


setStateForRoute : Model -> Navigation.Location -> Model
setStateForRoute model location =
    let
        route =
            getRoute location

        newModel =
            { model | route = route }
    in
        case route of
            CounterRoute ->
                { newModel | counter = Counter.initialModel }

            VotingRoute ->
                { newModel | voting = Voting.initialModel }

            _ ->
                newModel


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewUrl url ->
            ( model, Navigation.newUrl url )

        UrlChange location ->
            ( setStateForRoute model location, Cmd.none )

        CounterMsg subMsg ->
            let
                ( updatedCounter, cmd ) =
                    Counter.update subMsg model.counter
            in
                ( { model | counter = updatedCounter }, Cmd.map CounterMsg cmd )

        VotingMsg subMsg ->
            let
                ( updatedVoting, cmd ) =
                    Voting.update subMsg model.voting
            in
                ( { model | voting = updatedVoting }, Cmd.map VotingMsg cmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


homeView : Html Msg
homeView =
    div []
        [ h1 [] [ text "Elm Demos" ]
        , h4 [] [ text "Choose a link above to view one of the demos." ]
        ]


pageView : Model -> Html Msg
pageView model =
    case model.route of
        HomeRoute ->
            homeView

        CounterRoute ->
            Html.map CounterMsg (Counter.view model.counter)

        VotingRoute ->
            Html.map VotingMsg (Voting.view model.voting)


navView : Html Msg
navView =
    nav [ class "navbar navbar-default" ]
        [ div [ class "container" ]
            [ div [ class "navbar-header" ]
                [ a [ href "/", class "navbar-brand" ] [ text "Elm Demos" ] ]
            , ul [ class "nav navbar-nav" ]
                [ li []
                    [ a [ onClick (NewUrl "/") ]
                        [ text "Home" ]
                    ]
                , li []
                    [ a [ onClick (NewUrl "/01-counter") ]
                        [ text "01 - Counter App" ]
                    ]
                , li []
                    [ a [ onClick (NewUrl "/02-voting") ]
                        [ text "02 - Simple Voting App" ]
                    ]
                ]
            , ul [ class "nav navbar-nav navbar-right" ]
                [ li []
                    [ a [ href "https://github.com/jfairbank/elm-demos" ]
                        [ i [ class "fa fa-github fa-lg" ] [] ]
                    ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ navView
        , div [ class "container" ]
            [ pageView model ]
        ]


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
