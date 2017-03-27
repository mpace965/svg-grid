module Model exposing (..)

import Array2D exposing (Array2D, get, set)
import Time exposing (Time)


type Algorithm
    = Bfs BfsState


type alias BfsState =
    List Point


type alias Board =
    Array2D Cell


type Cell
    = Floor
    | Wall


type alias Model =
    { activeAlgorithm : Maybe Algorithm
    , board : Board
    , tickRate : Time
    }


type alias Point =
    { x : Int
    , y : Int
    }


getPoint : Point -> Array2D a -> Maybe a
getPoint point array =
    get point.x point.y array


setPoint : Point -> a -> Array2D a -> Array2D a
setPoint point element array =
    set point.x point.y element array


leftOf : Point -> Point
leftOf point =
    { x = point.x - 1
    , y = point.y
    }


rightOf : Point -> Point
rightOf point =
    { x = point.x + 1
    , y = point.y
    }


aboveOf : Point -> Point
aboveOf point =
    { x = point.x
    , y = point.y - 1
    }


belowOf : Point -> Point
belowOf point =
    { x = point.x
    , y = point.y + 1
    }
