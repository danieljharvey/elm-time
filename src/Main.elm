module Main exposing (..)

import Html exposing (Html)
import Html.Attributes


-- MODEL


type alias Model =
    List (List Int)


init : ( Model, Cmd Msg )
init =
    ( [ [ 0, 1 ]
      , [ 1, 0 ]
      ]
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp
    | ToggleCell Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- VIEW


drawItems : List Int -> Html Msg
drawItems m =
    Html.tr [] (List.map drawItem m)


wrapInDiv : Html Msg -> Html Msg
wrapInDiv a =
    Html.td
        [ Html.Attributes.height 20
        , Html.Attributes.width 20
        ]
        [ a ]


drawItem : Int -> Html Msg
drawItem i =
    wrapInDiv
        (case i of
            0 ->
                Html.p [ Html.Attributes.class "Nothing", Html.Attributes.height 20, Html.Attributes.width 20 ] []

            _ ->
                Html.img
                    [ Html.Attributes.src "./img/elm.png"
                    , Html.Attributes.width 20
                    , Html.Attributes.height 20
                    ]
                    []
        )


view : Model -> Html Msg
view model =
    Html.table
        []
        (List.map drawItems model)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
