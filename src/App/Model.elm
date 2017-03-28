module App.Model exposing (..)

import Time exposing (Time)


-- Project imports

import BfsAlgorithm.Model as BfsAlgorithm exposing (Model, initialModel)
import Board.Model as Board exposing (Model, Point, initialModel)


type Algorithm
    = Bfs Point


type alias Model =
    { activeAlgorithm : Maybe Algorithm
    , bfs : BfsAlgorithm.Model
    , board : Board.Model
    , tickRate : Maybe Time
    }


initialModel : Model
initialModel =
    { activeAlgorithm = Nothing
    , bfs = BfsAlgorithm.initialModel
    , board = Board.initialModel
    , tickRate = Nothing
    }
