module App.Shared exposing (..)

type alias Model = {}

initialModel : Model
initialModel = {}

type Msg = NoOp

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  ( model, Cmd.none )
