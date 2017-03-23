module App.Subscriptions exposing (subscriptions)

import App.Model exposing (Model)
import App.Message exposing (Msg(GetPoll))


pollServer : String
pollServer =
    "api.alexrieux.fr"


subscriptions : Model -> Sub Msg
-- TODO: Replace Sub.none with a WebSocket subscription to "ws://" ++ pollServer ++ "/socket"
-- and pass in GetPoll.
subscriptions model = Sub.none
