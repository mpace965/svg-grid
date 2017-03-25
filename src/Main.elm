module Main exposing (..)

import Array2D exposing (..)


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
