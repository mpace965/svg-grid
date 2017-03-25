module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- Project Imports

import Model exposing (..)
import Update exposing (..)
import SvgBoard exposing (renderBoard)


view : Model -> Html Msg
view model =
    let
        boardStyle =
            style
                [ ( "display", "flex" )
                , ( "alignItems", "center" )
                , ( "justifyContent", "center" )
                ]
    in
        div [ boardStyle ] [ (renderBoard model.board) ]
