module App.Update exposing (update)

import App.Message exposing (Msg(GetPoll, GetHttpPoll, PostHttpAnswer, SendAnswer))
import App.Model exposing (Model)
import App.Poll exposing (pollDecoder, postAnswer)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPoll pollStr ->
            -- TODO: Decode pollStr and set the state accordingly
            ( model, Cmd.none )

        GetHttpPoll (Ok val) ->
            -- TODO: Complete update of the model here
            ( model, Cmd.none )

        GetHttpPoll (Err _) ->
            ( model, Cmd.none )

        SendAnswer answerId ->
            ( model, postAnswer answerId )

        PostHttpAnswer (Ok val) ->
            ( { model | poll = Just val }, Cmd.none )

        PostHttpAnswer (Err _) ->
            ( model, Cmd.none )
