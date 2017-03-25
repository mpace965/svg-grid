module SvgBoard exposing (renderBoard)

import Array2D exposing (getRow, deleteRow)
import Array exposing (Array, toList, indexedMap)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- Project Imports

import Constants exposing (circleRadius, circleSpacer, numCols, numRows)
import Model exposing (..)
import Update exposing (..)


renderBoard : Board -> Svg Msg
renderBoard board =
    svg
        [ height (toString <| numRows * (2 * circleRadius + circleSpacer) + circleSpacer)
        , width (toString <| numCols * (2 * circleRadius + circleSpacer) + circleSpacer)
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
                        (offset + 2 * circleRadius + circleSpacer)
                        (rowList ++ [ (toSvg row offset) ])

                Nothing ->
                    rowList
    in
        buildRest board 0 []


toSvg : Array Cell -> Int -> Svg Msg
toSvg row offset =
    let
        makeCircle offset cell =
            circle
                [ cx (toString <| circleRadius + circleSpacer + offset * (2 * circleRadius + circleSpacer))
                , cy (toString <| circleRadius + circleSpacer)
                , fill (toColor cell)
                , r (toString circleRadius)
                , stroke "black"
                ]
                []
    in
        svg [ (y (toString offset)) ] (toList <| indexedMap makeCircle row)


toColor : Cell -> String
toColor cell =
    case cell of
        Floor ->
            "#F5F5F5"

        Wall ->
            "black"
