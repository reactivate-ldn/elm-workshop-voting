module App.Update exposing (update)

import Json.Decode exposing (Decoder, decodeString)
import App.Decoder exposing (answerDecoder, pollDecoder)
import App.Message exposing (Msg(GetPoll, GetHttpPoll, PostHttpAnswer, SendAnswer))
import App.Model exposing (Model)
import App.Request exposing (postAnswer)

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

        SendAnswer answerId ->
            ( model, postAnswer answerId )

        PostHttpAnswer (Ok val) ->
            ( { model | poll = Just val }, Cmd.none )

        PostHttpAnswer (Err _) ->
            ( model, Cmd.none )

