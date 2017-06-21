module QuoteOps exposing (parseResponse)

import Json.Decode as Json exposing (Value, map3, field, string)
import Http
import Types exposing (..)

parseResponse : Value -> Maybe (List Quote)
parseResponse resp =
    resp
        |> parseJsonString
        |> parseJsonQuoteValues


parseJsonString : Value -> Maybe String
parseJsonString s =
    Result.toMaybe (Json.decodeValue Json.string s)

parseJsonQuoteValues : Maybe String -> Maybe (List Quote)
parseJsonQuoteValues v =
    case v of
        Just a -> Result.toMaybe (Json.decodeString quotesDecoder a)
        Nothing -> Nothing

quoteDecoder : Json.Decoder Quote
quoteDecoder =
    map3 Quote
        (field "quote" string)
        (field "author" string)
        (field "category" string)

quotesDecoder : Json.Decoder (List Quote)
quotesDecoder =
    Json.list quoteDecoder

--getQuotes : Maybe (List Quote) -> List

--getQuotes : Http.Request (List Quote)
--getQuotes =
--    Http.get "http://localhost:3000" quotesDecoder
--
--getQuoteCmd : Cmd Action
--getQuoteCmd =
--    Http.send ReceivedQuotes getQuotes