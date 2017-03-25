module Main exposing (..)

import Array2D exposing (..)
import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- Project Imports

import Constants
import Model exposing (..)
import Update exposing (..)


main : Program Never Board Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


view : Board -> Html Msg
view board =
    let
        boardStyle =
            Html.Attributes.style
                [ ( "display", "flex" )
                , ( "alignItems", "center" )
                , ( "justifyContent", "center" )
                ]
    in
        div [ boardStyle ] [ (renderBoard board) ]


cellText : Cell -> String
cellText cell =
    case cell of
        Floor ->
            "0"

        Wall ->
            "1"


rowToDiv : Array String -> Html Msg
rowToDiv row =
    let
        toSpan string =
            span [] [ Html.text string ]
    in
        div [] (Array.toList (Array.map toSpan row))


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


renderTextBoard : Board -> Html Msg
renderTextBoard board =
    let
        textBoard =
            Array2D.map cellText board
    in
        div [] (textBoardToDivList textBoard)


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
                [ cx (toString <| Constants.circleRadius * 2 * (offset + 1) + (5 * offset))
                , cy (toString <| Constants.circleRadius + 5)
                , fill (toColor cell)
                , r (toString Constants.circleRadius)
                , stroke "black"
                ]
                []
    in
        svg [ (y (toString offset)) ] (Array.toList <| Array.indexedMap makeCircle row)


toRows : Board -> List (Svg Msg)
toRows board =
    let
        buildRest board offset rowList =
            case (getRow 0 board) of
                Just row ->
                    buildRest (deleteRow 0 board) (offset + 2 * Constants.circleRadius + 5) (rowList ++ [ (toSvg row offset) ])

                Nothing ->
                    rowList
    in
        buildRest board 0 []


renderBoard : Board -> Html Msg
renderBoard board =
    svg [ Svg.Attributes.height "500" ] (toRows board)
