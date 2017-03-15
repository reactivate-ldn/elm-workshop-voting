module App.Shared exposing (..)

import WebSocket
import App.Request exposing (getFirstPoll, postAnswer)
import App.Message exposing (..)
import App.Model exposing (..)
import App.Decoder exposing (..)
import Json.Decode exposing (decodeString)

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
