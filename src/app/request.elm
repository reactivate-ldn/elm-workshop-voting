module App.Request exposing (getFirstPoll, postAnswer)

import Http
import Json.Encode exposing (encode, object, string)

import App.Decoder exposing (answerDecoder, pollDecoder)
import App.Message exposing (Msg(GetHttpPoll, PostHttpAnswer))

getFirstPoll : Cmd Msg
getFirstPoll = Http.send GetHttpPoll <| Http.get "http://api.alexrieux.fr/poll?pollId=1234" pollDecoder

postAnswer : String -> Cmd Msg
postAnswer answerId =
  let
    url = "http://api.alexrieux.fr/poll/vote"
    args = (Json.Encode.object [("pollId", Json.Encode.string "1234"), ("answerId", Json.Encode.string answerId)])
    body = Http.stringBody "application/json" (encode 0 args)
  in
    Http.send PostHttpAnswer <| (Http.post url body) pollDecoder
