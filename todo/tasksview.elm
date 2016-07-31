module Todo.TasksView exposing ( view )
import HtmlHelper exposing ( li_, ul_, makeButton )
import Todo.TasksModel as TasksModel exposing ( Model, TaskId, toList )
import Todo.TasksUpdate as TasksUpdate exposing ( Msg(..) )
import Html exposing ( Html )
import Html.App as App
import Todo.Task as Task

type alias Task = Task.Model

view : Model -> Html Msg
view =
  ul_ << List.map liFromTuple << toList << .tasks

liFromTuple : (TaskId, Task) -> Html Msg
liFromTuple (id, task) =
  li_ [ deleteButton id, taskView id task ]

liftHtmlTaskMsgToHtmlMsg : TaskId -> Html Task.Msg -> Html Msg
liftHtmlTaskMsgToHtmlMsg  =
  App.map << TaskMsg

deleteButton : TaskId -> Html Msg
deleteButton id = makeButton (DeleteTask id) "Delete"

taskView : TaskId -> Task -> Html Msg
taskView id task =
  liftHtmlTaskMsgToHtmlMsg id (Task.view task)