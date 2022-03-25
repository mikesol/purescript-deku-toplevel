module Deku.Example.Toplevel where

import Prelude

import Deku.Change (change)
import Deku.Control.Functions (u)
import Deku.Graph.Attribute (cb)
import Deku.Graph.DOM ((:=))
import Deku.Graph.DOM as D
import Deku.Pursx ((~!))
import Deku.Toplevel ((🚀))
import Effect (Effect)
import Type.Proxy (Proxy(..))

main :: Effect Unit
main =
  ( \push -> u $
      ( (Proxy :: _ """
<div ~mydiv~>
  <h1>hello!</h1>
  <p>this is what a no-frills deku app looks like</p>
  <p>it is powered by pursx, a html-like format inspired by jsx</p>
  <h2>Why Deku</h2>
  <li>
    <ul>It's fast</ul>
    <ul>
      Well, that's about it for now... it's fast,
      but perhaps it has other advantages!
    </ul>
  </li>
  <p>
    Gratuitous demo: click the button below
    to change the background of this div.
  </p>
  ~mybutton~
</div>
""") ~!
          { mydiv: []
          , mybutton: D.button [ D.OnClick := cb (const $ push unit) ] {}
          }
      )
  ) 🚀
     \_ -> const $ change
        { "root.psx.mydiv": D.div'attr
            [ D.Style := "background-color: rgb(195,212,209);" ]
        }
