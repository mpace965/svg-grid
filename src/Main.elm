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
