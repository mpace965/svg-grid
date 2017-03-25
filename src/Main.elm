module Main exposing (..)

import Array2D exposing (..)
import Html exposing (..)


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
    repeat 10 10 Floor


type Msg
    = ChangeCell Int Int Cell


update : Msg -> Board -> Board
update msg board =
    case msg of
        ChangeCell x y newCell ->
            set x y newCell board


view : Board -> Html Msg
view board =
    div [] []
