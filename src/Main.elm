module Main exposing (..)

import Html exposing (program)


-- Project imports

import App.Model exposing (Model)
import App.Update exposing (Msg, init, update, subscriptions)
import App.View exposing (view)


main : Program Never Model Msg
main =
    program
        { init = App.Update.init
        , view = App.View.view
        , update = App.Update.update
        , subscriptions = App.Update.subscriptions
        }
