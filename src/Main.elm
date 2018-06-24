module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events exposing (onClick)


-- MODEL


type alias Point =
    { x : Int, y : Int }


type alias Board a =
    List (List a)


type alias Model =
    { board : Board Bool
    }


default : Model
default =
    { board = List.repeat 100 (List.repeat 100 False) }


init : ( Model, Cmd Msg )
init =
    ( default
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp
    | ToggleCell Point


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleCell point ->
            ( { board = toggleCells point model.board }, Cmd.none )


toggleCells : Point -> Board Bool -> Board Bool
toggleCells point cells =
    List.indexedMap (toggleRow point) cells


toggleRow : Point -> Int -> List Bool -> List Bool
toggleRow point index row =
    if index == point.y then
        List.indexedMap (toggleItem point) row
    else
        row


toggleItem : Point -> Int -> Bool -> Bool
toggleItem point index item =
    if index == point.x then
        not item
    else
        item



-- VIEW


drawItems : Int -> List Bool -> Html Msg
drawItems y m =
    Html.tr [] (List.indexedMap (drawItem y) m)


wrapInDiv : Point -> Html Msg -> Html Msg
wrapInDiv point a =
    Html.td
        [ onClick (ToggleCell point)
        , Html.Attributes.height 20
        , Html.Attributes.width 20
        ]
        [ a ]


drawItem : Int -> Int -> Bool -> Html Msg
drawItem y x i =
    let
        point =
            { x = x, y = y }
    in
        wrapInDiv point
            (case i of
                False ->
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
        (List.indexedMap drawItems model.board)



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
