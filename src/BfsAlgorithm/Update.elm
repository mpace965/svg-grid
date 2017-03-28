module BfsAlgorithm.Update exposing (..)

import List exposing (filterMap, foldl, head, isEmpty, tail)


-- Project imports

import BfsAlgorithm.Model as BfsAlgorithm exposing (ExecutionState(..), Model, Queue, initialModel)
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
            head model.queue

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

        queue =
            case (tail model.queue) of
                Just rest ->
                    rest ++ currentNeighbors

                Nothing ->
                    currentNeighbors

        executionState =
            setExecutionState queue
    in
        { model
            | executionState = executionState
            , newBoard = newBoard
            , queue = queue
        }


neighbors : Board.Model -> Point -> Queue
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


markNeighbors : Queue -> Board.Model -> Board.Model
markNeighbors neighbors board =
    foldl (setPoint Marked) board neighbors


setExecutionState : Queue -> ExecutionState
setExecutionState queue =
    case (isEmpty queue) of
        True ->
            Terminated

        False ->
            Running
