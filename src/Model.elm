module Model exposing (..)

import Array2D exposing (Array2D, repeat, set)


-- Project Imports

import Constants exposing (numCols, numRows)


type Cell
    = Floor
    | Wall


type alias Board =
    Array2D Cell


model : Board
model =
    repeat numRows numCols Floor
