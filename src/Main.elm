module Main exposing (..)

import Html exposing (program)


-- Project Imports

import Model exposing (..)
import Update exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    program { init = init, view = view, update = update, subscriptions = subscriptions }
