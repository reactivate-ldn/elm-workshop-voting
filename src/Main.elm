module Main exposing (main)

import App.Shared exposing (initialModel, update, subscriptions)
import App.Model exposing (Model)
import App.View exposing (view)
import App.Message exposing (Msg)
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
