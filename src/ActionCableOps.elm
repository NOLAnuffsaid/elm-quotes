module ActionCableOps exposing (initActionCable, attemptSubscriptionAction)

import Types exposing (..)
import ActionCable exposing (..)
import ActionCable.Msg as ACMsg
import ActionCable.Identifier as ID

initActionCable : String -> ActionCable Action
initActionCable s =
    ActionCable.initCable s
        |> ActionCable.onWelcome (Just OnWelcome)
        |> ActionCable.onDidReceiveData (Just HandleData)

channelID : String -> ID.Identifier
channelID chan = ID.newIdentifier chan [("id", "client")]

attemptSubscriptionAction
    : (ID.Identifier -> ActionCable Action -> Result ActionCableError (ActionCable Action, Cmd Action))
    -> String
    -> Model
    -> (Model, Cmd Action)
attemptSubscriptionAction fn chan m =
    let
        subFn = fn (channelID chan) m.socket
    in
        subFn
            |> Result.toMaybe
            |> handleSubscriptionAction m

handleSubscriptionAction : Model -> Maybe (ActionCable Action, Cmd Action) -> (Model, Cmd Action)
handleSubscriptionAction m r =
        case r of
            Just (s, cmd) -> {m | errors = Nothing, socket = s} ! [cmd]
            Nothing -> {m | errors = Just "Errors are happening!"} ! []