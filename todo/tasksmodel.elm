module Todo.TasksModel exposing ( Model, TaskId, Tasks, init, defaultTask
                                , toList, appendNew, appendNewUsingNumber, delete, updateTask )
import Dict as Dict exposing ( Dict, values )
import Html exposing ( Html )
import HtmlHelper exposing ( li_, ul_ )
import Todo.Task as Task

type alias Task = Task.Model
type alias TaskId = Int
type alias Tasks = Dict TaskId Task
type alias Model =
  { tasks : Tasks }

init : Model
init = { tasks = Dict.empty }

defaultTask : TaskId -> Task
defaultTask taskId =
  let
    stringId = toString taskId
    newName = "New Task " ++ stringId
  in
    Task.rename Task.empty newName

toList : Tasks -> List (TaskId, Task)
toList = Dict.toList

appendNew : Tasks -> Tasks
appendNew tasks =
  let
    taskId = nextTaskId tasks
    newTask = defaultTask taskId
  in
    Dict.insert taskId newTask tasks

appendNewUsingNumber : Int -> Tasks -> Tasks
appendNewUsingNumber number tasks =
  let
    taskId = nextTaskId tasks
    newTask = defaultTask number
  in
    Dict.insert taskId newTask tasks


delete : TaskId -> Tasks -> Tasks
delete deleteId tasks =
  let
    toKeep id task = id /= deleteId
  in
    Dict.filter toKeep tasks

maxTaskId : Tasks -> TaskId
maxTaskId =
  Maybe.withDefault 0 << maybeMaxTaskId

taskIds : Tasks -> List TaskId
taskIds = Dict.keys

maybeMaxTaskId : Tasks -> Maybe TaskId
maybeMaxTaskId = List.maximum << taskIds

nextTaskId : Tasks -> TaskId
nextTaskId tasks =
  (maxTaskId tasks) + 1

updateTask : TaskId -> Task.Msg -> Tasks -> Tasks
updateTask id msg tasks =
  let
    updater = Maybe.map (Task.update msg)
  in
    Dict.update id updater tasks
