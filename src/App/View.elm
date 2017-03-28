module App.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Time exposing (Time)


-- Project imports

import App.Model as App exposing (Algorithm, Model)
import App.Update exposing (Msg)
import Board.Model exposing (createPoint)
import Board.Update exposing (Msg)
import Board.View exposing (view)
import Constants exposing (..)


view : Model -> Html App.Update.Msg
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
            [ Board.View.view model.board
            , div []
                [ viewBfsButton model.activeAlgorithm
                , viewPauseButton model.activeAlgorithm model.tickRate
                , viewResetButton model.activeAlgorithm
                ]
            ]


viewBfsButton : Maybe Algorithm -> Html App.Update.Msg
viewBfsButton algorithm =
    let
        bfsStartingPoint =
            (createPoint 3 4)
    in
        case algorithm of
            Just _ ->
                button [ disabled True ] [ text "Breadth First Search" ]

            Nothing ->
                button [ onClick (App.Update.StartAlgorithm (App.Bfs bfsStartingPoint)) ] [ text "Breadth First Search" ]


viewPauseButton : Maybe Algorithm -> Maybe Time -> Html App.Update.Msg
viewPauseButton algorithm time =
    case algorithm of
        Just _ ->
            case time of
                Just _ ->
                    button [ onClick (App.Update.SetTickRate Nothing) ] [ text "Pause" ]

                Nothing ->
                    button [ onClick (App.Update.SetTickRate (Just defaultTickRate)) ] [ text "Unpause" ]

        Nothing ->
            button [ disabled True ] [ text "Pause" ]


viewResetButton : Maybe Algorithm -> Html App.Update.Msg
viewResetButton algorithm =
    case algorithm of
        Just _ ->
            button [ disabled True ] [ text "Reset" ]

        Nothing ->
            button [ onClick (App.Update.ChildBoardMsg Board.Update.ResetBoard) ] [ text "Reset" ]
