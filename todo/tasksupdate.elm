module Todo.TasksUpdate exposing ( Msg(..), update )
import Todo.TasksModel as TasksModel exposing ( Tasks, Model, TaskId, defaultTask, appendNew, delete, updateTask)
import Todo.Task as Task
import Dict as Dict exposing ( Dict, values )

type Msg
  = AddTask
  | DeleteTask TaskId
  | TaskMsg TaskId Task.Msg

update : Msg -> Model -> Model
update message =
  case message of
    AddTask ->
      updateTasks appendNew
    DeleteTask id ->
      updateTasks (delete id)
    TaskMsg id msg ->
      updateTasks (updateTask id msg)

updateTasks : (Tasks -> Tasks) -> Model -> Model
updateTasks updater model =
  { model | tasks = updater model.tasks }