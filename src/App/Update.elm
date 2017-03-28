module App.Update exposing (..)

import Time exposing (Time, every, millisecond)


-- Project imports

import App.Model as App exposing (Algorithm, Model, initialModel)
import BfsAlgorithm.Model exposing (ExecutionState, initialModel)
import BfsAlgorithm.Update exposing (update)
import Board.Model exposing (Point, initialModel)
import Board.Update exposing (Msg)
import Constants exposing (defaultTickRate)


type Msg
    = ChildBoardMsg Board.Update.Msg
    | SetTickRate (Maybe Time)
    | StartAlgorithm Algorithm
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

        StartAlgorithm algorithm ->
            let
                baseModel =
                    { model
                        | activeAlgorithm = Just algorithm
                        , tickRate = Just defaultTickRate
                        , board = Board.Model.initialModel
                    }
            in
                startAlgorithm baseModel algorithm

        Tick _ ->
            case model.activeAlgorithm of
                Just algorithm ->
                    stepBoard model algorithm

                Nothing ->
                    ( model, Cmd.none )


startAlgorithm : Model -> Algorithm -> ( Model, Cmd Msg )
startAlgorithm model algorithm =
    case algorithm of
        App.Bfs point ->
            let
                initialBfsModel =
                    BfsAlgorithm.Model.initialModel

                bfs =
                    { initialBfsModel | stack = [ point ] }
            in
                ( { model | bfs = bfs }
                , Cmd.none
                )


stepBoard : Model -> Algorithm -> ( Model, Cmd Msg )
stepBoard model algorithm =
    case algorithm of
        App.Bfs _ ->
            let
                bfs =
                    BfsAlgorithm.Update.update model.board model.bfs

                ( activeAlgorithm, tickRate ) =
                    case bfs.executionState of
                        BfsAlgorithm.Model.Terminated ->
                            ( Nothing, Nothing )

                        _ ->
                            ( model.activeAlgorithm, model.tickRate )
            in
                ( { model
                    | activeAlgorithm = activeAlgorithm
                    , board = bfs.newBoard
                    , bfs = bfs
                    , tickRate = tickRate
                  }
                , Cmd.none
                )


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
