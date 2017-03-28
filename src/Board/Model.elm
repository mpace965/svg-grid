module Board.Model exposing (..)

import Array2D exposing (Array2D, get, repeat, set)


-- Project imports

import Constants exposing (numCols, numRows)


type alias Model =
    Array2D Cell


type Cell
    = Floor
    | Wall
    | Marked


type alias Point =
    { x : Int
    , y : Int
    }


initialModel : Model
initialModel =
    repeat numRows numCols Floor


createPoint : Int -> Int -> Point
createPoint x y =
    { x = x
    , y = y
    }


getPoint : Point -> Array2D a -> Maybe a
getPoint point array =
    get point.x point.y array


setPoint : a -> Point -> Array2D a -> Array2D a
setPoint element point array =
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
