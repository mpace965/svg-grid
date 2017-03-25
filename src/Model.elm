module Model exposing (..)

import Array2D exposing (Array2D, repeat)
import Constants exposing (numCols, numRows)


type Cell
    = Floor
    | Wall


type alias Board =
    Array2D Cell


model : Board
model =
    (repeat numRows numCols Floor)
        |> Array2D.set 0 0 Wall
