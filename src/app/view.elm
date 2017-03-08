module App.View exposing (..)

import App.Chart.View exposing (chart)
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (style)
import App.Shared exposing (Model, Msg)

-- Container

containerStyle : List (String, String)
containerStyle =
  [ ("margin", "0 auto")
  , ("max-width", "100%")
  , ("width", "1000px")
  , ("height", "100%")
  , ("padding", "3rem")
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
  ]

title : String -> Html Msg
title label =
  h1 [ style titleStyle ]
    [ text label ]

-- Main View

view : Model -> Html Msg
view model =
  container
    [ title "Loading..."
    , chart (450, 300)
    ]

