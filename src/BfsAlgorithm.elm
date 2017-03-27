module BfsAlgorithm exposing (..)

import List exposing (filterMap, head, isEmpty, tail)
import Maybe exposing (andThen, withDefault)


-- Project Imports

import Model exposing (..)


newAlgorithm : BfsState -> Maybe Algorithm
newAlgorithm state =
    case (isEmpty state) of
        True ->
            Nothing

        False ->
            Just (Bfs state)


floorPoint : Board -> Point -> Maybe Point
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


neighbors : Board -> Point -> List Point
neighbors board point =
    let
        adjacent =
            [ (leftOf point), (rightOf point), (aboveOf point), (belowOf point) ]
    in
        filterMap (floorPoint board) adjacent


updateBoard : Board -> BfsState -> Maybe Point -> List Point -> ( Board, BfsState )
updateBoard oldBoard oldState point neighbors =
    let
        newBoard =
            case point of
                Just point ->
                    setPoint point Wall oldBoard

                Nothing ->
                    oldBoard

        newState =
            case (tail oldState) of
                Just rest ->
                    rest ++ neighbors

                Nothing ->
                    neighbors
    in
        ( newBoard, newState )


nextStep : Board -> BfsState -> ( Board, BfsState )
nextStep board state =
    let
        currentPoint =
            head state

        currentNeighbors =
            case currentPoint of
                Just point ->
                    neighbors board point

                Nothing ->
                    []
    in
        updateBoard board state currentPoint currentNeighbors


update : Model -> BfsState -> Model
update model state =
    let
        ( newBoard, newState ) =
            nextStep model.board state

        newModel =
            { model
                | board = newBoard
                , activeAlgorithm = (newAlgorithm newState)
            }
    in
        newModel
