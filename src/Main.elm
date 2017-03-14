module Main exposing (main)

import App.Shared exposing (Model, initialModel, Msg, update, subscriptions)
import App.View exposing (view)

import Html exposing (..)

init : ( Model, Cmd Msg )
init = initialModel

main =
    Html.program
    { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
    }
