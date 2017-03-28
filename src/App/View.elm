module App.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- Project imports

import App.Model as App exposing (Algorithm(..), Model, TickRate)
import App.Update exposing (Msg(..))
import Board.Model exposing (createPoint)
import Board.View exposing (view)
import Toggle exposing (Toggle(..))


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
            [ Board.View.view model.board
            , div []
                [ viewBfsButton model.activeAlgorithm
                , viewPauseButton model.activeAlgorithm model.tickRate
                , viewResetButton model.tickRate
                ]
            ]


viewBfsButton : Maybe Algorithm -> Html Msg
viewBfsButton algorithm =
    let
        bfsStartingPoint =
            (createPoint 3 4)
    in
        case algorithm of
            Just _ ->
                button [ disabled True ] [ text "Breadth First Search" ]

            Nothing ->
                button [ onClick (StartAlgorithm (Bfs bfsStartingPoint)) ] [ text "Breadth First Search" ]


viewPauseButton : Maybe Algorithm -> TickRate -> Html Msg
viewPauseButton algorithm time =
    case algorithm of
        Just _ ->
            case time of
                On rate ->
                    button [ onClick (SetTickRate (Off rate)) ] [ text "Pause" ]

                Off rate ->
                    button [ onClick (SetTickRate (On rate)) ] [ text "Unpause" ]

        Nothing ->
            button [ disabled True ] [ text "Pause" ]


viewResetButton : TickRate -> Html Msg
viewResetButton algorithm =
    case algorithm of
        On _ ->
            button [ disabled True ] [ text "Reset" ]

        Off _ ->
            button [ onClick Reset ] [ text "Reset" ]
