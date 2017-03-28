module Board.View exposing (view)

import Array2D exposing (getRow, deleteRow)
import Array exposing (Array, toList, indexedMap)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- Project imports

import Board.Model as Board exposing (Cell(..), Model)
import Constants exposing (circleRadius, circleSpacer, numCols, numRows)


totalCircleSize : number
totalCircleSize =
    2 * circleRadius + circleSpacer


view : Model -> Svg msg
view model =
    let
        totalSize dim =
            dim * totalCircleSize + circleSpacer
    in
        svg
            [ height (totalSize numRows |> toString)
            , width (totalSize numCols |> toString)
            ]
            (toRows model)


toRows : Model -> List (Svg msg)
toRows board =
    let
        buildRest board offset rowList =
            case (getRow 0 board) of
                Just row ->
                    buildRest
                        (deleteRow 0 board)
                        (offset + totalCircleSize)
                        (rowList ++ [ (toSvg row offset) ])

                Nothing ->
                    rowList
    in
        buildRest board 0 []


toSvg : Array Cell -> Int -> Svg msg
toSvg row offset =
    let
        initial =
            circleRadius + circleSpacer

        makeCircle offset cell =
            circle
                [ cx (initial + offset * totalCircleSize |> toString)
                , cy (toString initial)
                , fill (toColor cell)
                , r (toString circleRadius)
                , stroke "black"
                ]
                []
    in
        svg [ (y (toString offset)) ] (indexedMap makeCircle row |> toList)


toColor : Cell -> String
toColor cell =
    case cell of
        Floor ->
            "#F5F5F5"

        Wall ->
            "black"

        Marked ->
            "gray"
