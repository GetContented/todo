module Todo exposing ( main )
import HtmlHelper exposing ( li_, ul_, div_ )
import Todo.Tasks as Tasks
import Html.App as App
import Html exposing ( Html, div, button, text )
import Random
import Html.Events exposing ( onClick )

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions }

-- Model

type alias Tasks = Tasks.Model
type alias Model =
  { tasks : Tasks
  }

init : (Model, Cmd Msg)
init =
  ( { tasks = emptyTasks }
  , Cmd.none)

emptyTasks : Tasks
emptyTasks = Tasks.init

-- Update

type Msg
  = TasksMsg Tasks.Msg
  | MakeRandomTask

update : Msg -> Model -> (Model, Cmd Msg)
update message ({ tasks } as model) =
  case message of
    TasksMsg msg ->
      ({ model | tasks = Tasks.update msg tasks }, Cmd.none)
    MakeRandomTask ->
      (model, Random.generate (TasksMsg << Tasks.addNewWithRandom) (Random.int 1 6))

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- View

view : Model -> Html Msg
view ({tasks} as model) =
  div_
    [ newTaskButton
    , newRandomTaskButton
    , listView tasks
    ]

-- View / helpers

listView : Tasks -> Html Msg
listView =
  liftHtmlTasksMsgToHtmlMsg << Tasks.listView

newTaskButton : Html Msg
newTaskButton =
  liftHtmlTasksMsgToHtmlMsg Tasks.newButton

newRandomTaskButton : Html Msg
newRandomTaskButton =
  button [ onClick MakeRandomTask ]
    [ text "New Random Task"]


liftHtmlTasksMsgToHtmlMsg : Html Tasks.Msg -> Html Msg
liftHtmlTasksMsgToHtmlMsg =
  App.map TasksMsg
