module App.Poll exposing (getFirstPoll, pollDecoder, postAnswer)

import App.Message exposing (Msg(GetHttpPoll, PostHttpAnswer))
import App.Model exposing (Poll)
import Http
import Json.Decode exposing (Decoder, decodeString, int, string)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode exposing (encode, object, string)


--Constants


pollServer : String
pollServer =
    "api.alexrieux.fr"


pollId : String
pollId =
    "1234"



-- Decoders
-- TODO: add answerDecoder : Decoder Answer
-- Answer should be defined in App.Model


pollDecoder : Decoder Poll
pollDecoder =
    let
        string =
            Json.Decode.string
    in
        decode Poll
            |> required "id" string
            |> required "title" string



-- TODO: Add "answer" in Poll's model and decode it here using the answerDecoder defined before.
-- Hint: "answer: will be a list of Answer(s).
-- Requests


getFirstPoll : Cmd Msg
getFirstPoll =
    Http.send GetHttpPoll <| Http.get ("http://" ++ pollServer ++ "/poll?pollId=" ++ pollId) pollDecoder


postAnswer : String -> Cmd Msg
postAnswer answerId =
    let
        string =
            Json.Encode.string
    in
        let
            url =
                "http://" ++ pollServer ++ "/poll/vote"

            args =
                (object [ ( "pollId", string "1234" ), ( "answerId", string answerId ) ])

            body =
                Http.stringBody "application/json" (encode 0 args)
        in
            Http.send PostHttpAnswer <| (Http.post url body) pollDecoder
