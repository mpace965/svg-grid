module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


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

        bfsStartingState =
            [ (createPoint 3 4) ]
    in
        div [ boardStyle ]
            [ renderBoard model.board
            , button [ onClick (StartAlgorithm (Bfs bfsStartingState)) ] [ text "Breadth First Search" ]
            , button [ onClick (ChangeTickRate Nothing) ] [ text "Pause" ]
            ]
