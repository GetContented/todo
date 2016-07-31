module HtmlHelper exposing ( li_, ul_, div_, makeButton )
import Html exposing ( Html, div, button, ul, li, text )
import Html.Events exposing ( onClick )

li_ = li []
ul_ = ul []
div_ = div []

makeButton : a -> String -> Html a
makeButton message label =
  button [ onClick message ]
    [ text label ]
