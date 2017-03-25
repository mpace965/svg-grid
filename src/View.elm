module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- Project Imports

import Model exposing (..)
import Update exposing (..)
import SvgBoard exposing (renderBoard)


view : Board -> Html Msg
view board =
    let
        boardStyle =
            style
                [ ( "display", "flex" )
                , ( "alignItems", "center" )
                , ( "justifyContent", "center" )
                ]
    in
        div [ boardStyle ] [ (renderBoard board) ]
