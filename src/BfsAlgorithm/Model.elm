module BfsAlgorithm.Model exposing (..)

-- Project imports

import Board.Model as Board exposing (Model, Point, createPoint, initialModel)


type ExecutionState
    = Waiting
    | Running
    | Terminated


type alias Queue =
    List Point


type alias Model =
    { executionState : ExecutionState
    , newBoard : Board.Model
    , queue : Queue
    }


initialModel : Model
initialModel =
    { executionState = Terminated
    , newBoard = Board.initialModel
    , queue = [ (createPoint 0 0) ]
    }
