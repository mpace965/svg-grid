module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Time exposing (Time)


-- Project Imports

import Constants exposing (..)
import Model exposing (..)
import Update exposing (..)
import SvgBoard exposing (renderBoard)


renderPauseButton : Maybe Algorithm -> Maybe Time -> Html Msg
renderPauseButton algorithm time =
    case algorithm of
        Just _ ->
            case time of
                Just _ ->
                    button [ onClick (ChangeTickRate Nothing) ] [ text "Pause" ]

                Nothing ->
                    button [ onClick (ChangeTickRate (Just defaultTickRate)) ] [ text "Unpause" ]

        Nothing ->
            button [ disabled True ] [ text "Pause" ]


view : Model -> Html Msg
view model =
    let
        boardStyle =
            style
                [ ( "display", "flex" )
                , ( "alignItems", "center" )
                , ( "justifyContent", "center" )
                , ( "flexDirection", "column" )
                ]

        bfsStartingState =
            [ (createPoint 3 4) ]
    in
        div [ boardStyle ]
            [ renderBoard model.board
            , div []
                [ button [ onClick (StartAlgorithm (Bfs bfsStartingState)) ] [ text "Breadth First Search" ]
                , (renderPauseButton model.activeAlgorithm model.tickRate)
                , button [ onClick (ResetBoard) ] [ text "Reset" ]
                ]
            ]
