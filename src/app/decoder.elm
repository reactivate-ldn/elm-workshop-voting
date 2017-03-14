module App.Decoder exposing (..)

import App.Model exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)

answerDecoder : Decoder Answer
answerDecoder = 
  decode Answer
    |> required "id" string
    |> required "answer" string
    |> required "votes" int

pollDecoder : Decoder Poll
pollDecoder =
  decode Poll
    |> required "id" string
    |> required "title" string
    |> required "answer" (list answerDecoder)