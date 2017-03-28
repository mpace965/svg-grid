module BfsAlgorithm.Model exposing (..)

-- Project imports

import Board.Model as Board exposing (Model, Point, createPoint, initialModel)


type ExecutionState
    = Waiting
    | Running
    | Terminated


type alias Model =
    { executionState : ExecutionState
    , newBoard : Board.Model
    , stack : List Point
    }


initialModel : Model
initialModel =
    { executionState = Terminated
    , newBoard = Board.initialModel
    , stack = [ (createPoint 0 0) ]
    }
