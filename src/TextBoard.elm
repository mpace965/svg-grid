module TextBoard exposing (renderBoard)

import Array2D exposing (Array2D, deleteRow, getRow)
import Array exposing (Array, map, toList)
import Html exposing (..)


-- Project Imports

import Model exposing (..)
import Update exposing (..)


renderBoard : Board -> Html Msg
renderBoard board =
    let
        textBoard =
            Array2D.map cellText board
    in
        div [] (textBoardToDivList textBoard)


textBoardToDivList : Array2D String -> List (Html Msg)
textBoardToDivList textBoard =
    let
        buildRest textBoard divList =
            case (getRow 0 textBoard) of
                Just row ->
                    buildRest (deleteRow 0 textBoard) (divList ++ [ (rowToDiv row) ])

                Nothing ->
                    divList
    in
        buildRest textBoard []


rowToDiv : Array String -> Html Msg
rowToDiv row =
    let
        toSpan string =
            span [] [ text string ]
    in
        div [] (toList (Array.map toSpan row))


cellText : Cell -> String
cellText cell =
    case cell of
        Floor ->
            "0"

        Wall ->
            "1"
