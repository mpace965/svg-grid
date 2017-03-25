module Main exposing (..)

import Html exposing (beginnerProgram)


-- Project Imports

import Model exposing (..)
import Update exposing (..)
import View exposing (..)


main : Program Never Board Msg
main =
    beginnerProgram { model = model, view = view, update = update }
