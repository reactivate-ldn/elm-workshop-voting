module App.Request exposing (getFirstPoll, postAnswer)

import Http
import Json.Encode exposing (encode, object, string)
import App.Decoder exposing (answerDecoder, pollDecoder)
import App.Message exposing (Msg(GetHttpPoll, PostHttpAnswer))


pollServer : String
pollServer =
    "api.alexrieux.fr"


pollId : String
pollId =
    "1234"


getFirstPoll : Cmd Msg
getFirstPoll =
    Http.send GetHttpPoll <| Http.get ("http://" ++ pollServer ++ "/poll?pollId=" ++ pollId) pollDecoder


postAnswer : String -> Cmd Msg
postAnswer answerId =
    let
        url =
            "http://" ++ pollServer ++ "/poll/vote"

        args =
            (Json.Encode.object [ ( "pollId", Json.Encode.string "1234" ), ( "answerId", Json.Encode.string answerId ) ])

        body =
            Http.stringBody "application/json" (encode 0 args)
    in
        Http.send PostHttpAnswer <| (Http.post url body) pollDecoder
