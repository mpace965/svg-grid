module SvgBoard exposing (renderBoard)

import Array2D exposing (getRow, deleteRow)
import Array exposing (Array, toList, indexedMap)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- Project Imports

import Constants exposing (circleRadius)
import Model exposing (..)
import Update exposing (..)


toColor : Cell -> String
toColor cell =
    case cell of
        Floor ->
            "white"

        Wall ->
            "black"


toSvg : Array Cell -> Int -> Svg Msg
toSvg row offset =
    let
        makeCircle offset cell =
            circle
                [ cx (toString <| circleRadius * 2 * (offset + 1) + (5 * offset))
                , cy (toString <| circleRadius + 5)
                , fill (toColor cell)
                , r (toString circleRadius)
                , stroke "black"
                ]
                []
    in
        svg [ (y (toString offset)) ] (toList <| indexedMap makeCircle row)


toRows : Board -> List (Svg Msg)
toRows board =
    let
        buildRest board offset rowList =
            case (getRow 0 board) of
                Just row ->
                    buildRest (deleteRow 0 board) (offset + 2 * circleRadius + 5) (rowList ++ [ (toSvg row offset) ])

                Nothing ->
                    rowList
    in
        buildRest board 0 []


renderBoard : Board -> Svg Msg
renderBoard board =
    svg [ Svg.Attributes.height "500" ] (toRows board)
