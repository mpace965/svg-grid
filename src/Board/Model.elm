module Board.Model exposing (..)

import Array2D exposing (Array2D, get, repeat, set)
import Tuple exposing (first, second)


-- Project imports

import Constants exposing (numCols, numRows)


type alias Model =
    Array2D Cell


type Cell
    = Floor
    | Wall
    | Marked


type alias Point =
    ( Int, Int )


initialModel : Model
initialModel =
    repeat numRows numCols Floor


getPoint : Point -> Array2D a -> Maybe a
getPoint point array =
    get (first point) (second point) array


setPoint : a -> Point -> Array2D a -> Array2D a
setPoint element point array =
    set (first point) (second point) element array


leftOf : Point -> Point
leftOf point =
    ( (first point) - 1, (second point) )


rightOf : Point -> Point
rightOf point =
    ( (first point) + 1, (second point) )


aboveOf : Point -> Point
aboveOf point =
    ( (first point), (second point) + 1 )


belowOf : Point -> Point
belowOf point =
    ( (first point), (second point) - 1 )
