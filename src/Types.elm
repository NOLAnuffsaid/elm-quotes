module Types exposing (..)

import Http
import Json.Decode as Json
import ActionCable exposing (ActionCable)
import ActionCable.Msg exposing (Msg)
import ActionCable.Identifier as Id

type alias Quote =
    { quote : String
    , author : String
    , category : String
    }

type alias Model =
    { quotes : List Quote
    , errors : Maybe String
    , socket : ActionCable Action
    }

type alias ChannelId =
    { channel : String
    , id : List (String, String)
    }

type Action
    = CableMsg Msg
    | HandleData Id.Identifier Json.Value
    | SubscribeTo String
    | UnsubscribeFrom String
    | OnWelcome ()
