module App.Chart exposing (chart)

import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, g, rect)
import Svg.Attributes exposing (height, width, viewBox, x, y, fill, fontSize, textAnchor, color)
import List exposing (map, indexedMap, length, maximum)

import App.Message exposing(Msg)
import App.Model exposing(Answer)

barWidth : Int
barWidth = 8

chartStyle : List (String, String)
chartStyle =
  [ ("height", "auto")
  , ("width", "100%")
  ]

bar : (Int, Int) -> (String, Int, Float) -> Svg Msg
bar (xSize, ySize) (label, xPos, yHeight) =
  g []
    [ rect
      [ width (toString barWidth)
      , height (toString yHeight)
      , x (toString (xPos - barWidth // 2))
      , y (toString (toFloat ySize - yHeight))
      , fill "#FFBD24"
      ] []
    , Svg.text_
      [ x (toString xPos)
      , y (toString (toFloat ySize - yHeight - toFloat 7))
      , fontSize "13"
      , color "rgba(255, 255, 255, 0.85)"
      , textAnchor "middle"
      ] [ Svg.text label ]
    ]

calcBarDimensions : (Int, Int) -> (Int, Int) -> Int -> (String, Int) -> (String, Int, Float)
calcBarDimensions (xSize, ySizeInt) (barsLength, maxVotes) index (name, votes) =
  let
    ySize = toFloat ySizeInt
    xPos = (xSize // barsLength) * index + (xSize // barsLength) // 2
    yHeight = min ySize (toFloat votes / toFloat maxVotes * ySize)
  in
    (name, xPos, yHeight)

calcBarsDimensions : (Int, Int) -> List (String, Int) -> List (String, Int, Float)
calcBarsDimensions dimensions bars =
  let
    barsLength = length bars
    maxVotes = Maybe.withDefault 0 (maximum (List.map (\(_, votes) -> votes) bars))
  in
    indexedMap (calcBarDimensions dimensions (barsLength, maxVotes)) bars

chart : (Int, Int) -> List Answer -> Svg Msg
chart dimensions answers =
  let
    (xSize, ySize) = dimensions
    paddedDimensions = (xSize, ySize - 20)
    barsDimensions = calcBarsDimensions paddedDimensions (List.map (\item -> (item.answer, item.votes)) answers)
  in
    svg
      [ height (toString ySize)
      , width (toString xSize)
      , viewBox "0 0 450 300"
      , style chartStyle
      ]
      [ g []
        (List.map (\x -> bar dimensions x) barsDimensions)
      ]
