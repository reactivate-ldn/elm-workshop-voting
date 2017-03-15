module Main exposing (main)

import App.Shared exposing (update, subscriptions)
import App.Model exposing (Model)
import App.View exposing (view)
import App.Request exposing (getFirstPoll)
import App.Message exposing (Msg)
import Html exposing (..)

init : ( Model, Cmd Msg )
init = ({ poll = Nothing }, getFirstPoll)

main : Program Never Model Msg
main =
    Html.program
    { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
    }
