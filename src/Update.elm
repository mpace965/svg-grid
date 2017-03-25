module Update exposing (..)

import Array2D exposing (repeat, set)
import Time exposing (Time, every, millisecond)


-- Project Imports

import Constants exposing (defaultTickRate, numCols, numRows)
import Model exposing (..)


type Msg
    = ChangeCell Int Int Cell
    | Tick Time


init : ( Model, Cmd Msg )
init =
    let
        model =
            { board = (repeat numRows numCols Floor)
            , tickRate = defaultTickRate
            }
    in
        ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeCell x y newCell ->
            ( { model | board = (set x y newCell model.board) }, Cmd.none )

        Tick newTime ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    every (model.tickRate * millisecond) Tick
