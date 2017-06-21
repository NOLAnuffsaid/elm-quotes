module Update exposing (update)

import Task
import Types exposing (..)
import ActionCableOps exposing (attemptSubscriptionAction)
import QuoteOps exposing (parseResponse)
import ActionCable exposing (..)
import ActionCable.Identifier as ID
import ActionCable.Msg exposing (Msg)

update : Action -> Model -> (Model, Cmd Action)
update a m =
    case a of
        OnWelcome () ->
            let
                t = Task.perform SubscribeTo (Task.succeed "QuotesChannel")
            in
                m ![t]

        CableMsg msg ->
            ActionCable.update msg m.socket
                |> (\( cable, cmd ) -> { m | socket = cable} ! [ cmd ])

        HandleData id v ->
            case (parseResponse v) of
                Just a -> {m | quotes = List.append m.quotes a} ! []
                Nothing -> m ! []

        SubscribeTo chan ->
            attemptSubscriptionAction ActionCable.subscribeTo chan m

        UnsubscribeFrom chan ->
            attemptSubscriptionAction ActionCable.unsubscribeFrom chan m