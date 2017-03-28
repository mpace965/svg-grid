module App.Model exposing (..)

import Time exposing (Time)


-- Project imports

import Board.Model as Board exposing (Model, initialModel)


type alias Model =
    { board : Board.Model
    , tickRate : Maybe Time
    }


initialModel : Model
initialModel =
    { board = Board.initialModel
    , tickRate = Nothing
    }
