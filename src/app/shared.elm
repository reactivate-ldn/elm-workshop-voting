module App.Shared exposing (..)

import WebSocket
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)

type alias Answer = {
    answer: String
  , id: String
  , votes: Int
}

type alias Poll = {
    id: String
  , title: String
  , answer: List Answer
}

type alias Model = {
  poll: Poll
}

initialModel = ({ poll = { id = "foo", title = "bar", answer = [ { answer = "asd", id = "asd", votes = 1 }]} }, Cmd.none)

type Msg
  = NoOp
  | GetPoll String

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

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    GetPoll pollStr ->
      case (decodeString pollDecoder pollStr) of
        Ok val -> 
          ( { model | poll = val }, Cmd.none )
        Err err ->
          ( model, Cmd.none )
    NoOp -> ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://localhost:8080/socket" GetPoll
