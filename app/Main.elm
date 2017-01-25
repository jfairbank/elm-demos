module Main exposing (..)

import Counter
import Voting
import Navigation
import Router exposing (getRoute, Route(..))
import Components.Nav as Nav exposing (navItem, navView)
import Html exposing (a, div, h1, h4, i, li, nav, text, ul, Html)
import Html.Attributes exposing (class, classList, href, style)
import Utils.Op exposing ((=>))


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


demoInfo : String -> String -> Html msg
demoInfo sourceCodeUrl header =
    div [ style [ "textAlign" => "center" ] ]
        [ h1 [] [ text header ]
        , a [ href sourceCodeUrl ] [ text "Source Code" ]
        ]


repoUrl : String -> String
repoUrl =
    (++) "https://github.com/jfairbank/elm-demos/"


demoCodeUrl : String -> String
demoCodeUrl =
    (++) (repoUrl "tree/master/")


pageView : Model -> Html Msg
pageView model =
    case model.route of
        HomeRoute ->
            homeView

        CounterRoute ->
            div []
                [ demoInfo (demoCodeUrl "01-counter") "01 - Counter App"
                , Html.map CounterMsg (Counter.view model.counter)
                ]

        VotingRoute ->
            div []
                [ demoInfo (demoCodeUrl "02-voting") "02 - Simple Voting App"
                , Html.map VotingMsg (Voting.view model.voting)
                ]


historyNavItem : String -> String -> Html Msg
historyNavItem =
    Nav.historyNavItem NewUrl


navbarView : Html Msg
navbarView =
    nav [ class "navbar navbar-default" ]
        [ div [ class "container" ]
            [ div [ class "navbar-header" ]
                [ a [ href "/", class "navbar-brand" ] [ text "Elm Demos" ] ]
            , navView Nav.Left
                [ historyNavItem "/" "Home"
                , historyNavItem "/01-counter" "01 - Counter App"
                , historyNavItem "/02-voting" "02 - Simple Voting App"
                ]
            , navView Nav.Right
                [ navItem "https://github.com/jfairbank/elm-demos"
                    (i [ class "fa fa-github fa-lg" ] [])
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ navbarView
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
