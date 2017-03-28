module BfsAlgorithm.Update exposing (..)

import List exposing (filterMap, foldl, head, isEmpty, tail)


-- Project imports

import BfsAlgorithm.Model as BfsAlgorithm exposing (ExecutionState, Model, initialModel)
import Board.Model as Board exposing (..)


type alias Model =
    BfsAlgorithm.Model


init : Model
init =
    BfsAlgorithm.initialModel


update : Board.Model -> Model -> Model
update board model =
    let
        currentPoint =
            head model.stack

        currentNeighbors =
            case currentPoint of
                Just point ->
                    neighbors board point

                Nothing ->
                    []

        newBoard =
            case currentPoint of
                Just point ->
                    (setPoint Wall point board)
                        |> markNeighbors currentNeighbors

                Nothing ->
                    board

        stack =
            case (tail model.stack) of
                Just rest ->
                    rest ++ currentNeighbors

                Nothing ->
                    currentNeighbors

        executionState =
            setExecutionState stack
    in
        { model
            | executionState = executionState
            , newBoard = newBoard
            , stack = stack
        }


neighbors : Board.Model -> Point -> List Point
neighbors board point =
    let
        adjacent =
            [ (leftOf point), (rightOf point), (aboveOf point), (belowOf point) ]
    in
        filterMap (floorPoint board) adjacent


floorPoint : Board.Model -> Point -> Maybe Point
floorPoint board point =
    case (getPoint point board) of
        Just cell ->
            case cell of
                Floor ->
                    Just point

                _ ->
                    Nothing

        Nothing ->
            Nothing


markNeighbors : List Point -> Board.Model -> Board.Model
markNeighbors neighbors board =
    foldl (setPoint Marked) board neighbors


setExecutionState : List Point -> ExecutionState
setExecutionState stack =
    case (isEmpty stack) of
        True ->
            BfsAlgorithm.Terminated

        False ->
            BfsAlgorithm.Running
