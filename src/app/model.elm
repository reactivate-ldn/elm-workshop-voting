module App.Model exposing (Model, Poll)

-- TODO: define type alias for Answer here with id and answer as strings and votes as a number.


type alias Poll =
    { id : String
    , title :
        String
        -- TODO: add answer here as a list of Answer
    }


type alias Model =
    { poll : Maybe Poll
    }
