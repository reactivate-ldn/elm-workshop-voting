module Main exposing (main)

import Html
import App.Message exposing (Msg)
import App.Model exposing (Answer, Model, Poll)
import App.Poll exposing (getFirstPoll)
import App.Update exposing (update)
import App.Subscriptions exposing (subscriptions)
import App.View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( { poll = Nothing }, getFirstPoll )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
