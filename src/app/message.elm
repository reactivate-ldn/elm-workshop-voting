module App.Message exposing (..)

import Http
import App.Model exposing (Poll)

type Msg
  = NoOp
  | GetPoll String
  | GetHttpPoll (Result Http.Error Poll)
  | SendAnswer String
  | PostHttpAnswer (Result Http.Error Poll)
