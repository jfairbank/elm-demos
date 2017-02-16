module View exposing (..)

import Counter
import StarWars
import Components.Nav as Nav exposing (navItem, navView)
import Html exposing (Html, a, div, h1, h4, i, li, nav, text, ul)
import Html.Attributes exposing (class, classList, href, style)
import Model exposing (Model)
import Router exposing (getRoute, Route(..))
import Update exposing (Msg(..))
import Utils.Op exposing ((=>))


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
repoUrl path =
    "https://github.com/jfairbank/elm-demos/" ++ path


demoCodeUrl : String -> String
demoCodeUrl demoUrl =
    (repoUrl "tree/master/") ++ demoUrl


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

        StarWarsRoute ->
            div []
                [ demoInfo (demoCodeUrl "02-star-wars") "02 - Star Wars App"
                , Html.map StarWarsMsg (StarWars.view model.starWars)
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
                , historyNavItem "/02-star-wars" "02 - Star Wars App"
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
