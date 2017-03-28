module Board.Update exposing (..)

import Board.Model as Board exposing (..)


type Msg
    = ChangeCell Point Cell
    | ResetBoard


type alias Model =
    Board.Model


init : ( Model, Cmd Msg )
init =
    ( Board.initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeCell point cell ->
            ( setPoint cell point model, Cmd.none )

        ResetBoard ->
            ( Board.initialModel, Cmd.none )
