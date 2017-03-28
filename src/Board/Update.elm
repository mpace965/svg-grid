module Board.Update exposing (..)

import Board.Model as Board exposing (..)


type Msg
    = ResetBoard
    | SetCell Point Cell


type alias Model =
    Board.Model


init : Model
init =
    Board.initialModel


update : Msg -> Model -> Model
update msg model =
    case msg of
        ResetBoard ->
            Board.initialModel

        SetCell point cell ->
            setPoint cell point model
