module StarWars.Update exposing (..)

import Http
import StarWars.Model exposing (..)


type Msg
    = UpdateQuery String
    | PerformSearch
    | ReceiveResults (Result Http.Error (List Person))
    | SetViewState ViewState


searchPeople : String -> Cmd Msg
searchPeople query =
    let
        url =
            "http://swapi.co/api/people/?search=" ++ query
    in
        Http.send ReceiveResults (Http.get url searchResultsDecoder)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateQuery query ->
            ( { model | query = query }
            , Cmd.none
            )

        PerformSearch ->
            ( { model | viewState = Search Searching }
            , searchPeople model.query
            )

        ReceiveResults result ->
            case result of
                Ok searchResults ->
                    ( { model
                        | searchResults = searchResults
                        , viewState = Search Done
                      }
                    , Cmd.none
                    )

                Err _ ->
                    ( model, Cmd.none )

        SetViewState viewState ->
            ( { model | viewState = viewState }
            , Cmd.none
            )
