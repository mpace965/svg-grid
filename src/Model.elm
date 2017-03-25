module Model exposing (..)

import Array2D exposing (Array2D)
import Time exposing (Time)


-- Project Imports


type Cell
    = Floor
    | Wall


type alias Board =
    Array2D Cell


type alias Model =
    { board : Board
    , tickRate : Time
    }
