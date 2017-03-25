module Main exposing (..)

import Array2D exposing (..)
import Array exposing (Array)
import Html exposing (..)
import Html.Attributes exposing (..)


main : Program Never Board Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type Cell
    = Floor
    | Wall


type alias Board =
    Array2D Cell


model : Board
model =
    (repeat 10 10 Floor)
        |> set 0 0 Wall


type Msg
    = ChangeCell Int Int Cell


update : Msg -> Board -> Board
update msg board =
    case msg of
        ChangeCell x y newCell ->
            set x y newCell board


view : Board -> Html Msg
view board =
    let
        boardStyle =
            style
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
            span [] [ text string ]
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


renderBoard : Board -> Html Msg
renderBoard board =
    let
        textBoard =
            Array2D.map cellText board
    in
        div [] (textBoardToDivList textBoard)
