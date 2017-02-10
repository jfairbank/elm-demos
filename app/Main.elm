module Main exposing (..)

import Counter
import Voting
import Navigation
import Components.Nav as Nav exposing (navItem, navView)
import Html exposing (a, div, h1, h4, i, li, nav, text, ul, Html)
import Html.Attributes exposing (class, classList, href, style)
import Monocle.Lens exposing (Lens)
import Return exposing (Return)
import Return.Optics exposing (refractl)
import Router exposing (getRoute, Route(..))
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


init : Navigation.Location -> Return Msg Model
init location =
    ( initialModel location, Cmd.none )


counterl : Lens Model Counter.Model
counterl =
    Lens .counter (\c m -> { m | counter = c })


votingl : Lens Model Voting.Model
votingl =
    Lens .voting (\v m -> { m | voting = v })


routel : Lens Model Route
routel =
    Lens .route (\r m -> { m | route = r })


setStateForLocation : Navigation.Location -> Model -> Model
setStateForLocation location =
    let
        route =
            getRoute location
    in
        .set routel route
            >> case route of
                CounterRoute ->
                    .set counterl Counter.initialModel

                VotingRoute ->
                    .set votingl Voting.initialModel

                _ ->
                    identity


update : Msg -> Model -> Return Msg Model
update msg =
    Return.singleton
        >> case msg of
            NewUrl url ->
                Return.command (Navigation.newUrl url)

            UrlChange location ->
                Return.map (setStateForLocation location)

            CounterMsg subMsg ->
                refractl counterl CounterMsg (Counter.update subMsg)

            VotingMsg subMsg ->
                refractl votingl VotingMsg (Voting.update subMsg)


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
