module App exposing (main)

import Http
import Html
import View
import Types exposing (..)
import ActionCable
import ActionCable.Identifier as ID
import ActionCable.Msg exposing (Msg)
import ActionCableOps exposing (initActionCable)

import Update


subs : Model -> Sub Action
subs m =
    ActionCable.listen CableMsg m.socket

init : (Model, Cmd Action)
init = { quotes = []
       , errors = Nothing
       , socket = initActionCable "ws://localhost:3000/cable"
       } ! []

main =
    Html.program { init = init
                 , view = View.view
                 , update = Update.update
                 , subscriptions = subs
                 }