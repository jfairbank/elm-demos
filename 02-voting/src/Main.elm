module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


type alias Model =
    { option1 : Int
    , option2 : Int
    }


type Msg
    = VoteOption1
    | VoteOption2


initialModel : Model
initialModel =
    Model 0 0


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        VoteOption1 ->
            ( { model | option1 = model.option1 + 1 }, Cmd.none )

        VoteOption2 ->
            ( { model | option2 = model.option2 + 1 }, Cmd.none )


displayVoteCount : Int -> String
displayVoteCount votes =
    if votes == 1 then
        "1 Vote"
    else
        (toString votes) ++ " Votes"


optionView : Msg -> String -> Int -> Html Msg
optionView msg description votes =
    li []
        [ div []
            [ text description
            , span [] [ text (displayVoteCount votes) ]
            ]
        , button [ onClick msg ] [ text "Vote" ]
        ]


voteView : String -> Model -> Html Msg
voteView description model =
    div [ class "voteable" ]
        [ h2 [] [ text description ]
        , ul []
            [ optionView VoteOption1 "Yes! 😄" model.option1
            , optionView VoteOption2 "No! 😢" model.option2
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "simple-voting-02" ]
        [ h1 [] [ text "Vote On:" ]
        , voteView "Is Elm Awesome?" model
        ]


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
