module Update exposing (..)

import Array2D exposing (repeat, set)
import Time exposing (Time, every, millisecond)


-- Project Imports

import BfsAlgorithm exposing (update)
import Constants exposing (defaultTickRate, numCols, numRows)
import Model exposing (..)


type Msg
    = ChangeCell Point Cell
    | StartAlgorithm Algorithm
    | Tick Time


init : ( Model, Cmd Msg )
init =
    let
        initialBoard =
            repeat numRows numCols Floor

        model =
            { activeAlgorithm = Nothing
            , board = initialBoard
            , tickRate = defaultTickRate
            }
    in
        ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeCell point newCell ->
            ( { model | board = (set point.x point.y newCell model.board) }, Cmd.none )

        StartAlgorithm algorithm ->
            ( { model | activeAlgorithm = Just algorithm }, Cmd.none )

        Tick newTime ->
            case model.activeAlgorithm of
                Just algorithm ->
                    case algorithm of
                        Bfs state ->
                            ( BfsAlgorithm.update model state, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    every (model.tickRate * millisecond) Tick
