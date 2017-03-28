module App.Update exposing (..)

import Time exposing (Time, every, millisecond)


-- Project imports

import App.Model as App exposing (Model, initialModel)
import Board.Update exposing (Msg)


type Msg
    = ChildBoardMsg Board.Update.Msg
    | SetTickRate (Maybe Time)
    | Tick Time


type alias Model =
    App.Model


init : ( Model, Cmd Msg )
init =
    ( App.initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChildBoardMsg msg ->
            ( { model | board = Board.Update.update msg model.board }, Cmd.none )

        SetTickRate time ->
            ( { model | tickRate = time }
            , Cmd.none
            )

        Tick _ ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        appSub =
            case model.tickRate of
                Just tickRate ->
                    every (tickRate * millisecond) Tick

                Nothing ->
                    Sub.none
    in
        Sub.batch
            [ appSub
              -- Put child subscriptions here if needed
            ]
