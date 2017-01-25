module Components.Nav exposing (..)

import Html exposing (a, li, text, ul, Html)
import Html.Attributes exposing (classList, href)
import Html.Events exposing (onClick)
import Utils.Op exposing ((=>))


type Position
    = Left
    | Right


historyNavItem : (String -> msg) -> String -> String -> Html msg
historyNavItem msgCreator url title =
    li [] [ a [ onClick (msgCreator url) ] [ text title ] ]


navItem : String -> Html msg -> Html msg
navItem url child =
    li [] [ a [ href url ] [ child ] ]


navView : Position -> List (Html msg) -> Html msg
navView position children =
    ul
        [ classList
            [ "nav" => True
            , "navbar-nav" => True
            , "navbar-right" => (position == Right)
            ]
        ]
        children
