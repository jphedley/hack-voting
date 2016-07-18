module View exposing (root)

import Event.View
import Exts.Html.Bootstrap exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import RemoteData exposing (..)
import Types exposing (..)


root : Model -> Html Msg
root model =
    div []
        [ header []
            [ container
                [ row
                    [ div [ class "col-xs-12 col-md-9" ]
                        [ h1 [] [ text "Vote-o-Matic" ]
                        ]
                    , button
                        [ class "btn btn-lg btn-primary col-xs-12 col-sm-3"
                        , onClick Authenticate
                        , disabled (canAuthenticate model)
                        ]
                        [ text "Log In" ]
                    ]
                ]
            ]
        , container
            [ case model.auth of
                Success user ->
                    case model.eventModel of
                        Nothing ->
                            text "Initialising."

                        Just eventModel ->
                            Event.View.root user eventModel
                                |> Html.map EventMsg

                Failure err ->
                    div [ class "alert alert-danger" ] [ text err.message ]

                Loading ->
                    h2 [] [ i [] [ text "Checking your account." ] ]

                NotAsked ->
                    h2 [] [ text "Log in to view and vote." ]
            ]
        ]


canAuthenticate : Model -> Bool
canAuthenticate model =
    case model.auth of
        Loading ->
            True

        Success _ ->
            True

        NotAsked ->
            False

        Failure _ ->
            False
