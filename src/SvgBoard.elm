module SvgBoard exposing (renderBoard)

import Array2D exposing (getRow, deleteRow)
import Array exposing (Array, toList, indexedMap)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- Project Imports

import Constants exposing (circleRadius, circleSpacer, numCols, numRows)
import Model exposing (..)
import Update exposing (..)


totalCircleSize : number
totalCircleSize =
    2 * circleRadius + circleSpacer


renderBoard : Board -> Svg Msg
renderBoard board =
    let
        totalSize dim =
            dim * totalCircleSize + circleSpacer
    in
        svg
            [ height (totalSize numRows |> toString)
            , width (totalSize numCols |> toString)
            ]
            (toRows board)


toRows : Board -> List (Svg Msg)
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


toSvg : Array Cell -> Int -> Svg Msg
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
