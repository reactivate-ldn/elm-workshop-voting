module App.Model exposing (..)

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