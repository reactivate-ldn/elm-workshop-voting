module Main exposing (main)

import App.Shared exposing (Model, initialModel, Msg, update)
import App.View exposing (view)
import App.Subscriptions exposing (subscriptions)

import Html exposing (programWithFlags)

init : String -> ( Model, Cmd Msg )
init path =
  ( initialModel, Cmd.none )

main : Program String Model Msg
main =
    programWithFlags { view = view, init = init, update = update, subscriptions = subscriptions }
