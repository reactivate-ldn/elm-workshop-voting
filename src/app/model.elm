module App.Model exposing (Model, Poll)

-- TODO: define type alias for Answer.
-- Hint: check docs on http://api.alexrieux.fr/ to figure out the shape of it.


type alias Poll =
    { id : String
    , title :
        String
        -- TODO: add answer here as a list of Answer
    }


type alias Model =
    { poll : Maybe Poll
    }
