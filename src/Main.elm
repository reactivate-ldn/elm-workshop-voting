module Main exposing (main)

import Html
import App.Message exposing (Msg)
import App.Model exposing (Model)
import App.Update exposing (update)
import App.Subscriptions exposing (subscriptions)
import App.View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { view = view
        -- TODO: Replace Cmd.none with the actual command needed to load the initial poll data.
        -- Hint: check poll.elm
        , init = ({ poll = Nothing }, Cmd.none)
        , update = update
        , subscriptions = subscriptions
        }
