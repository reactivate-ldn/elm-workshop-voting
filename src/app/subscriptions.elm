module App.Subscriptions exposing (subscriptions)

import App.Model exposing (Model)
import App.Message exposing (Msg(GetPoll))


-- buildPollUrl : String -> Maybe String -> String
-- TODO: complete the function that generates the url to reach the API
-- The first parameter is the protocol, the second one is an optional endpoint.


subscriptions : Model -> Sub Msg


-- TODO: Replace Sub.none with a WebSocket subscription to "ws://api.alexrieux.fr/socket"
-- and pass in GetPoll. Use buildPollUrl to get the url

subscriptions model =
    Sub.none
