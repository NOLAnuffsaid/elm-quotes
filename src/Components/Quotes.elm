module Components.Quotes exposing (quoteComponent)

import Html exposing (Html, div, span, node)
import Html.Attributes exposing (classList, type_)
import Types exposing (Quote)
import Css exposing (..)

type CssClasses
    = QuoteContainer
    | QuoteRow
    | QuoteSmallText
    | QuoteSmallTextRow

quoteContainerCss =
    [ displayFlex
    , alignItems center
    , justifyContent spaceAround
    , flexDirection column
    , height (vh 100)
    , width (vw 100)
    ]

quoteRowCss =
    [ displayFlex
    , justifyContent center
    , flexDirection row
    , width (vw 100)
    , fontSize (Css.rem 2)
    ]

quoteSmallTextRowCss =
    [ displayFlex
    , flexDirection column
    , alignItems flexEnd
    , justifyContent spaceBetween
    , width (vw 100)
    , paddingRight (vw 30)
    , textTransform capitalize
    , fontSize (Css.rem 0.75)
    ]

styles = asPairs >> Html.Attributes.style

quoteComponent : Quote -> Html a
quoteComponent q =
    div [ styles quoteContainerCss, Html.Attributes.class "QuoteContainer"]
        [ div [ styles quoteRowCss, classList [("Row", True), ("QuoteRow", True)] ]
            [ Html.text q.quote ]
        , div [ styles quoteSmallTextRowCss, classList [("Row", True), ("QuoteSmallTextRow", True)] ]
            [ span [ Html.Attributes.class "QuoteSmallText" ] [ Html.text q.author ]
            ]
        ]