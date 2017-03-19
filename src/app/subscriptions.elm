module App.Subscriptions exposing (subscriptions)

import WebSocket
import App.Model exposing (Model)
import App.Message exposing (Msg(GetPoll))

pollServer : String
pollServer =
    "api.alexrieux.fr"

subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen ("ws://" ++ pollServer ++ "//socket") GetPoll