module App.Shared exposing (..)

import WebSocket
import Http
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode exposing (encode, object)

type alias Answer = {
    id: String
  , answer: String
  , votes: Int
}

type alias Poll = {
    id: String
  , title: String
  , answer: List Answer
}

type alias Model = {
  poll: Maybe Poll
}

initialModel = ({ poll = Nothing }, getFirstPoll)

type Msg
  = NoOp
  | GetPoll String
  | GetHttpPoll (Result Http.Error Poll)
  | SendAnswer String
  | PostHttpAnswer (Result Http.Error Poll)

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
          ( { model | poll = Just val }, Cmd.none )
        Err err ->
          ( model, Cmd.none )
    GetHttpPoll (Ok val) ->
      ( { model | poll = Just val }, Cmd.none )
    GetHttpPoll (Err _) ->
      ( model, Cmd.none )
    NoOp -> ( model, Cmd.none )
    SendAnswer answerId ->
      (model, postAnswer answerId)
    PostHttpAnswer (Ok val) ->
      ( { model | poll = Just val }, Cmd.none )
    PostHttpAnswer (Err _) ->
      ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://localhost:8080/socket" GetPoll

getFirstPoll : Cmd Msg
getFirstPoll = Http.send GetHttpPoll (Http.get "http://localhost:8080/poll?pollId=1234" pollDecoder)

postAnswer : String -> Cmd Msg
postAnswer answerId = 
  let
    url = "http://localhost:8080/poll/vote"
    body =
      Http.stringBody "application/json" (encode 0 (object [("pollId", Json.Encode.string "1234"), ("answerId", Json.Encode.string answerId)]))
  in
    Http.send PostHttpAnswer ((Http.post url body) pollDecoder)
