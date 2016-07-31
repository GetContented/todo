module Todo.Tasks exposing ( Model, Msg, init, update, view
                           , newButton, listView )
import HtmlHelper exposing ( li_, ul_, div_, makeButton )
import Todo.TasksModel as TasksModel exposing ( Model, init )
import Todo.TasksUpdate as TasksUpdate exposing ( Msg(..) )
import Todo.TasksView as TasksView
import Html.App as App
import Todo.Task as Task
import Html exposing ( Html, text, button )
import Html.Events exposing ( onClick )

-- Model

type alias Model = TasksModel.Model
init = TasksModel.init

-- Update

type alias Msg = TasksUpdate.Msg

update : Msg -> Model -> Model
update = TasksUpdate.update

-- View

view : Model -> Html Msg
view model =
  div_
    [ newButton
    , listView model ]

newButton : Html Msg
newButton =
  button [ onClick AddTask ]
    [ text "New Task"]

listView : Model -> Html Msg
listView = TasksView.view
