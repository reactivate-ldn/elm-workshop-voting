module App.Request exposing (..)

import Http
-- import App.Shared exposing (..)
import App.Message exposing (..)
import App.Decoder exposing (..)

import Json.Encode exposing (encode, object, string)

getFirstPoll : Cmd Msg
getFirstPoll = Http.send GetHttpPoll <| Http.get "http://localhost:8080/poll?pollId=1234" pollDecoder

postAnswer : String -> Cmd Msg
postAnswer answerId = 
  let
    url = "http://localhost:8080/poll/vote"
    args = (object [("pollId", string "1234"), ("answerId", string answerId)])
    body = Http.stringBody "application/json" (encode 0 args)
  in
    Http.send PostHttpAnswer <| (Http.post url body) pollDecoder
