module App.Message exposing (..)

import Http
import App.Model exposing (Poll)

type Msg
  = GetPoll String
  | GetHttpPoll (Result Http.Error Poll)
  | SendAnswer String
  | PostHttpAnswer (Result Http.Error Poll)
