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


renderBfsButton : Maybe Algorithm -> Html Msg
renderBfsButton algorithm =
    let
        bfsStartingState =
            [ (createPoint 3 4) ]
    in
        case algorithm of
            Just _ ->
                button [ disabled True ] [ text "Breadth First Search" ]

            Nothing ->
                button [ onClick (StartAlgorithm (Bfs bfsStartingState)) ] [ text "Breadth First Search" ]


renderResetButton : Maybe Algorithm -> Html Msg
renderResetButton algorithm =
    case algorithm of
        Just _ ->
            button [ disabled True ] [ text "Reset" ]

        Nothing ->
            button [ onClick (ResetBoard) ] [ text "Reset" ]


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
    in
        div [ boardStyle ]
            [ renderBoard model.board
            , div []
                [ (renderBfsButton model.activeAlgorithm)
                , (renderPauseButton model.activeAlgorithm model.tickRate)
                , (renderResetButton model.activeAlgorithm)
                ]
            ]
