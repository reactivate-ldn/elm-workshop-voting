module App.View exposing (view)

import App.Message exposing (Msg(SendAnswer))
import App.Model exposing (Answer, Model)
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


voteButton : Answer -> Html Msg
voteButton answer =
    a [ style voteButtonStyle, onClick (SendAnswer answer.id) ]
        [ text "+1" ]


voteButtons : List Answer -> Html Msg
voteButtons answers =
    div [ style voteButtonsStyle ] <| List.map voteButton answers



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


chart : ( Int, Int ) -> List Answer -> Svg Msg
chart dimensions answers =
    let
        ( xSize, ySize ) =
            dimensions

        paddedDimensions =
            ( xSize, ySize - 20 )

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
                [ title val.title, chart ( 450, 300 ) val.answer, voteButtons val.answer ]
        )
