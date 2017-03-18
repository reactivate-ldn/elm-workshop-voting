module App.Decoder exposing (answerDecoder, pollDecoder)

import Json.Decode exposing (Decoder, decodeString, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)

import App.Model exposing (Answer, Poll)

answerDecoder : Decoder Answer
answerDecoder =
  let string = Json.Decode.string
  in
    decode Answer
      |> required "id" string
      |> required "answer" string
      |> required "votes" int

pollDecoder : Decoder Poll
pollDecoder =
  let string = Json.Decode.string
  in
    decode Poll
      |> required "id" string
      |> required "title" string
      |> required "answer" (list answerDecoder)