module App.View exposing (..)

import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, g, rect)
import Svg.Attributes exposing (height, width, viewBox, x, y, fill)
import App.Shared exposing (Model, Msg)
import List exposing (map, indexedMap, length, maximum)
import Maybe exposing (withDefault)

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

-- Chart

chartStyle : List (String, String)
chartStyle =
  [ ("height", "auto")
  , ("width", "100%")
  ]

bar : (Int, Int) -> (String, Int, Float) -> Svg Msg
bar (xSize, ySize) (label, xPos, yHeight) =
  rect
    [ width "8"
    , height (toString yHeight)
    , x (toString xPos)
    , y (toString (toFloat ySize - yHeight))
    , fill "#FFBD24"
    ] []

bars : List (String, Int)
bars =
  [ ("React", 20)
  , ("Preact", 7)
  , ("Inferno", 5)
  , ("Elm", 10)
  ]

calcBarDimensions : (Int, Int) -> (Int, Int) -> Int -> (String, Int) -> (String, Int, Float)
calcBarDimensions (xSize, ySize) (barsLength, maxVotes) index (name, votes) =
  let
    xPos = (xSize // barsLength) * index + (xSize // barsLength) // 2 - 4
    yHeight = min 300 (toFloat votes / toFloat maxVotes * 300)
  in
    (name, xPos, yHeight)

calcBarsDimensions : (Int, Int) -> List (String, Int) -> List (String, Int, Float)
calcBarsDimensions dimensions bars =
  let
    barsLength = length bars
    maxVotes = withDefault 0 (maximum (map (\(_, votes) -> votes) bars))
  in
    indexedMap (calcBarDimensions dimensions (barsLength, maxVotes)) bars

chart : (Int, Int) -> Html Msg
chart dimensions =
  let
    (xSize, ySize) = dimensions
    barsDimensions = calcBarsDimensions dimensions bars
  in
    svg
      [ height (toString ySize)
      , width (toString xSize)
      , viewBox "0 0 450 300"
      , style chartStyle
      ]
      [ g []
        (map (\x -> bar dimensions x) barsDimensions)
      ]

-- Main View

view : Model -> Html Msg
view model =
  container
    [ title "Loading..."
    , chart (450, 300)
    ]
