module View exposing (view)

import Css exposing (..)
import Html exposing (Html, div, node)
import Html.Attributes exposing (class, type_)
import Components.Quotes exposing (..)
import Types exposing (..)

type AppCssClasses = ContentContainer

contentContainerCss =
    [ displayFlex
    , flexDirection row
    , flexWrap noWrap
    ]

styles = asPairs >> Html.Attributes.style

view : Model -> Html a
view m =
    let
        errors = case m.errors of
            Just e -> e
            Nothing -> ""
        _ = if String.isEmpty errors then "" else Debug.log "Errors: " errors
    in
        div [ styles contentContainerCss, Html.Attributes.class "ContentContainer" ]
            ( List.map (\q -> quoteComponent q) m.quotes )