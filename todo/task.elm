module Todo.Task exposing ( Model, empty, Msg, update, rename, view )
import Html exposing ( Html, Attribute, div, text, button, ul, li, input, span )
import HtmlHelper exposing ( li_, ul_, div_, makeButton )
import Html.Events exposing ( onClick, onInput, onBlur )
import Html.Attributes exposing ( value )

-- Model

type alias Model =
  { name : String
  , isEditing : Bool }

empty : Model
empty =
  { name = "unnamed"
  , isEditing = True
  }

-- Update

type Msg
  = Edit
  | DoneEditing
  | Rename String

update : Msg -> Model -> Model
update message model =
  case message of
    Rename newName ->
      { model | name = newName }
    Edit ->
      { model | isEditing = True }
    DoneEditing ->
      { model | isEditing = False }

rename : Model -> String -> Model
rename model newName =
  update (Rename newName) model

-- View

view : Model -> Html Msg
view {isEditing, name} =
  if isEditing
  then
    span [ onBlur DoneEditing ]
      [ input [ value name
              , onInput Rename
              , onBlur DoneEditing ]
              []
      , closeButton
      ]
  else
    span [ onClick Edit ]
      [ text name
      , editButton ]

editButton = makeButton Edit "Edit"
closeButton = makeButton DoneEditing "Done"

