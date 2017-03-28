module Board.Update exposing (..)

import Board.Model as Board exposing (..)


type Msg
    = ResetBoard
    | SetCell Point Cell


type alias Model =
    Board.Model


init : ( Model, Cmd Msg )
init =
    ( Board.initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ResetBoard ->
            ( Board.initialModel, Cmd.none )

        SetCell point cell ->
            ( setPoint cell point model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
