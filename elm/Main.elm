module Main exposing (main)

import Browser exposing (sandbox)
import Html exposing (Html, button, div, input, ul, li, span, text)
import Html.Attributes exposing (value)
import Html.Events exposing (on, onClick, onInput)
import Json.Decode as D
import String exposing (fromInt)


listRemove : Int -> List a -> List a
listRemove i xs =
    List.take i xs ++ List.drop (i + 1) xs


type alias Model =
    { tasks : List String, taskInput : String }


type Msg
    = TaskDelete Int
    | TaskInputChange String
    | TaskAdd


update : Msg -> Model -> Model
update msg model =
    case msg of
        TaskDelete idx ->
            { model | tasks = listRemove idx model.tasks }

        TaskInputChange new ->
            { model | taskInput = new }

        TaskAdd ->
            { model | tasks = model.taskInput :: model.tasks, taskInput = "" }


viewItem : Int -> String -> Html Msg
viewItem idx task =
    li []
        [ span [] [ text task ]
        , button [ onClick <| TaskDelete idx ] [ text "×" ]
        ]


onEnter : msg -> Html.Attribute msg
onEnter msg =
    on "keyup"
        (D.field "keyCode" D.int
            |> D.andThen
                (\keyCode ->
                    case keyCode of
                        13 ->
                            D.succeed msg

                        _ ->
                            D.fail ""
                )
        )


view : Model -> Html Msg
view model =
    div []
        [ ul [] <| List.indexedMap viewItem model.tasks
        , input [ onInput TaskInputChange, onEnter TaskAdd, value model.taskInput ] []
        ]


main : Program () Model Msg
main =
    sandbox
        { init =
            { tasks = [ "Task 1", "Task 2" ]
            , taskInput = ""
            }
        , view = view
        , update = update
        }
