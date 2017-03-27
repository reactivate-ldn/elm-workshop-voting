module App.View exposing (view)

import App.Message exposing (Msg(SendAnswer))
import App.Model exposing (Model)
import Html exposing (Html, a, div, h1, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import List exposing (map, indexedMap, length, maximum)
import Svg exposing (Svg, svg, g, rect)
import Svg.Attributes exposing (height, width, viewBox, x, y, fill, fontSize, textAnchor, color)


-- Container


containerStyle : List ( String, String )
containerStyle =
    [ ( "margin", "0 auto" )
    , ( "max-width", "100%" )
    , ( "width", "1000px" )
    , ( "height", "100%" )
    , ( "padding", "3rem 1rem 2rem" )
    , ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "align-items", "stretch" )
    ]



-- Title


titleStyle : List ( String, String )
titleStyle =
    [ ( "font-size", "3.7rem" )
    , ( "font-weight", "bold" )
    , ( "text-align", "center" )
    , ( "margin", "0" )
    , ( "margin-bottom", "2rem" )
    ]


title : String -> Html Msg
title label =
    h1 [ style titleStyle ]
        [ text label ]



-- Voting Buttons


voteButtonsStyle : List ( String, String )
voteButtonsStyle =
    [ ( "display", "flex" )
    , ( "flex-direction", "row" )
    , ( "justify-content", "space-around" )
    , ( "align-items", "center" )
    , ( "margin-top", "5rem" )
    ]


voteButtonStyle : List ( String, String )
voteButtonStyle =
    [ ( "display", "block" )
    , ( "cursor", "pointer" )
    , ( "border-radius", "50%" )
    , ( "width", "3rem" )
    , ( "height", "3rem" )
    , ( "background", "#FFBD24" )
    , ( "box-shadow", "0 0 0 0.6rem rgba(255, 189, 36, 0.3)" )
    , ( "font-size", "1.5rem" )
    , ( "text-align", "center" )
    , ( "line-height", "3rem" )
    , ( "vertical-align", "middle" )
    , ( "user-select", "none" )
    ]



-- TODO: define onClick behaviour for voteButton
-- voteButton : Answer -> Html Msg


voteButton answer =
    a [ style voteButtonStyle ]
        [ text "+1" ]



-- TODO: add voteButtons : List Answer -> Html Msg
-- div [] []
-- Hint: voteButtonsStyle is already defined. The childnode should be a map of voteButton over answers
-- Chart


barWidth : Int
barWidth =
    8


chartStyle : List ( String, String )
chartStyle =
    [ ( "height", "auto" )
    , ( "width", "100%" )
    ]


bar : ( Int, Int ) -> ( String, Int, Float ) -> Svg Msg
bar ( xSize, ySize ) ( label, xPos, yHeight ) =
    g []
        [ rect
            [ width (toString barWidth)
            , height (toString yHeight)
            , x (toString (xPos - barWidth // 2))
            , y (toString (toFloat ySize - yHeight))
            , fill "#FFBD24"
            ]
            []
        , Svg.text_
            [ x (toString xPos)
            , y (toString (toFloat ySize - yHeight - toFloat 7))
            , fontSize "13"
            , color "rgba(255, 255, 255, 0.85)"
            , textAnchor "middle"
            ]
            [ Svg.text label ]
        ]


calcBarDimensions : ( Int, Int ) -> ( Int, Int ) -> Int -> ( String, Int ) -> ( String, Int, Float )
calcBarDimensions ( xSize, ySizeInt ) ( barsLength, maxVotes ) index ( name, votes ) =
    let
        ySize =
            toFloat ySizeInt

        xPos =
            (xSize // barsLength) * index + (xSize // barsLength) // 2

        yHeight =
            min ySize (toFloat votes / toFloat maxVotes * ySize)
    in
        ( name, xPos, yHeight )


calcBarsDimensions : ( Int, Int ) -> List ( String, Int ) -> List ( String, Int, Float )
calcBarsDimensions dimensions bars =
    let
        barsLength =
            length bars

        maxVotes =
            Maybe.withDefault 0 (maximum (List.map (\( _, votes ) -> votes) bars))
    in
        indexedMap (calcBarDimensions dimensions ( barsLength, maxVotes )) bars



-- TODO: Change chart to accept as a second parameter a List of Answer


chart : ( Int, Int ) -> Svg Msg
chart dimensions =
    let
        ( xSize, ySize ) =
            dimensions

        paddedDimensions =
            ( xSize, ySize - 20 )

        answers =
            [ { id = ""
              , answer = "test"
              , votes = 1
              }
            ]

        barsDimensions =
            calcBarsDimensions paddedDimensions (List.map (\item -> ( item.answer, item.votes )) answers)
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



-- Main View


view : Model -> Html Msg
view model =
    div [ style containerStyle ] <|
        (case model.poll of
            Nothing ->
                [ title "Loading...", div [] [], div [] [] ]

            Just val ->
                -- TODO: Pass to chart the answers and render the vote buttons
                [ title val.title, chart ( 450, 300 ), div [] [] ]
        )
