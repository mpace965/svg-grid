module Update exposing (..)

import Array2D exposing (set)


-- Project Imports

import Model exposing (..)


type Msg
    = ChangeCell Int Int Cell


update : Msg -> Board -> Board
update msg board =
    case msg of
        ChangeCell x y newCell ->
            set x y newCell board
