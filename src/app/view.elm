module App.View exposing (..)

import App.Chart.View exposing (chart)
import Html exposing (Html, div, h1, text, a)
import Html.Attributes exposing (style)
import App.Shared exposing (..)

-- Container

containerStyle : List (String, String)
containerStyle =
  [ ("margin", "0 auto")
  , ("max-width", "100%")
  , ("width", "1000px")
  , ("height", "100%")
  , ("padding", "3rem 1rem 2rem")
  , ("display", "flex")
  , ("flex-direction", "column")
  , ("align-items", "stretch")
  ]

container : List (Html Msg) -> Html Msg
container children =
  div [ style containerStyle ] children

-- Title

titleStyle : List (String, String)
titleStyle =
  [ ("font-size", "3.7rem")
  , ("font-weight", "bold")
  , ("text-align", "center")
  , ("margin", "0")
  , ("margin-bottom", "2rem")
  ]

title : String -> Html Msg
title label =
  h1 [ style titleStyle ]
    [ text label ]

-- Voting Buttons

voteButtonsStyle : List (String, String)
voteButtonsStyle =
  [ ("display", "flex")
  , ("flex-direction", "row")
  , ("justify-content", "space-around")
  , ("align-items", "center")
  , ("margin-top", "5rem")
  ]

voteButtonStyle : List (String, String)
voteButtonStyle =
  [ ("display", "block")
  , ("cursor", "pointer")
  , ("border-radius", "50%")
  , ("width", "3rem")
  , ("height", "3rem")
  , ("background", "#FFBD24")
  , ("box-shadow", "0 0 0 0.6rem rgba(255, 189, 36, 0.3)")
  , ("font-size", "1.5rem")
  , ("text-align", "center")
  , ("line-height", "3rem")
  , ("vertical-align", "middle")
  , ("user-select", "none")
  ]

voteButton : Answer -> Html Msg
voteButton answer =
  a [ style voteButtonStyle ]
    [ text "+1" ]

voteButtons : List Answer -> Html Msg
voteButtons answers =
  div [ style voteButtonsStyle ] <| List.map voteButton answers

-- Main View

view : Model -> Html Msg
view model =
  container
    [
      case model.poll of
        Nothing ->
          title "Loading..."
        Just val ->
          title val.title
    , chart (450, 300)
    ,
      case model.poll of
        Nothing ->
          div[][]
        Just val ->
          voteButtons val.answer
    ]
