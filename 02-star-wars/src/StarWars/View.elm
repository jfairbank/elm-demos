module StarWars.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, disabled, value)
import Html.Events exposing (onClick, onInput)
import StarWars.Model exposing (..)
import StarWars.Update exposing (..)


personItemView : Person -> Html Msg
personItemView person =
    li []
        [ a [ onClick (SetViewState (Detail person)) ]
            [ text person.name ]
        ]


searchResultsView : SearchStatus -> List Person -> Html Msg
searchResultsView status searchResults =
    case status of
        Ready ->
            text ""

        Searching ->
            div [] [ text "Searching..." ]

        Done ->
            case searchResults of
                [] ->
                    div [] [ text "No Search Results" ]

                _ ->
                    div []
                        [ text "Search Results:"
                        , ul [] (List.map personItemView searchResults)
                        ]


trait : String -> String -> Html msg
trait title value =
    span []
        [ b [] [ text (title ++ ":") ]
        , text (" " ++ value)
        ]


childView : Model -> Html Msg
childView model =
    case .viewState model of
        Search status ->
            div [ class "star-wars-02__search" ]
                [ h2 [] [ text "Search Star Wars Characters" ]
                , label [] [ text "Name:" ]
                , input
                    [ value model.query
                    , onInput UpdateQuery
                    ]
                    []
                , button
                    [ disabled (model.query == "")
                    , onClick PerformSearch
                    ]
                    [ text "Search" ]
                , div [ class "star-wars-02__search-results" ]
                    [ searchResultsView status model.searchResults
                    ]
                ]

        Detail person ->
            div [ class "star-wars-02__detail" ]
                [ a [ onClick (SetViewState (Search Done)) ] [ text "« Back" ]
                , h2 [] [ text person.name ]
                , h4 [] [ text "Traits:" ]
                , table []
                    [ tbody []
                        [ tr []
                            [ th [] [ text "Height" ]
                            , td [] [ text person.height ]
                            ]
                        , tr []
                            [ th [] [ text "Eye Color" ]
                            , td [] [ text person.eyeColor ]
                            ]
                        , tr []
                            [ th [] [ text "Hair Color" ]
                            , td [] [ text person.hairColor ]
                            ]
                        , tr []
                            [ th [] [ text "Birth Year" ]
                            , td [] [ text person.birthYear ]
                            ]
                        ]
                    ]
                ]


view : Model -> Html Msg
view model =
    div [ class "star-wars-02" ]
        [ childView model ]
