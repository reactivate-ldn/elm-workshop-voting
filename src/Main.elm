module Main exposing (main)

import App.Shared exposing (Model, initialModel, Msg, update)
import App.View exposing (view)
import App.Subscriptions exposing (subscriptions)

import Html exposing (program)

init : ( Model, Cmd Msg )
init = ( initialModel, Cmd.none )

main : Program Never Model Msg
main =
    program { view = view, init = init, update = update, subscriptions = subscriptions }
