module Todo exposing ( main )
import HtmlHelper exposing ( li_, ul_, div_ )
import Todo.Tasks as Tasks
import Html.App as App
import Html exposing ( Html, div )

main =
  App.beginnerProgram { model = init
                      , view = view
                      , update = update }

-- Model

type alias Tasks = Tasks.Model
type alias Model =
  { tasks : Tasks
  }

init : Model
init =
  { tasks = emptyTasks
  }

emptyTasks : Tasks
emptyTasks = Tasks.init

-- Update

type Msg
  = TasksMsg Tasks.Msg

update : Msg -> Model -> Model
update message ({ tasks } as model) =
  case message of
    TasksMsg msg ->
      { model | tasks = Tasks.update msg tasks }

-- View

view : Model -> Html Msg
view ({tasks} as model) =
  div_
    [ newTaskButton
    , listView tasks
    ]

-- View / helpers

listView : Tasks -> Html Msg
listView =
  liftHtmlTasksMsgToHtmlMsg << Tasks.listView

newTaskButton : Html Msg
newTaskButton =
  liftHtmlTasksMsgToHtmlMsg Tasks.newButton

liftHtmlTasksMsgToHtmlMsg : Html Tasks.Msg -> Html Msg
liftHtmlTasksMsgToHtmlMsg =
  App.map TasksMsg
