module App.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


-- Project imports

import App.Model as App exposing (Model)
import App.Update exposing (Msg)
import Board.View exposing (view)


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
            ]
