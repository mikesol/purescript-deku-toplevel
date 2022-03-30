module Deku.Example.Toplevel where

import Prelude

import Deku.Change (change)
import Deku.Control.Functions (u)
import Deku.Graph.Attribute (cb)
import Deku.Graph.DOM ((:=))
import Deku.Graph.DOM as D
import Deku.Graph.DOM.Shorthand as S
import Deku.Pursx (psx, (~!))
import Deku.Toplevel ((🚀))
import Effect (Effect)
import Type.Proxy (Proxy(..))

px = Proxy :: Proxy  """
<div ~mydiv~>
  <h1>Hello!</h1>
  <p>This is what a no-frills deku app looks like.</p>
  <p>It is powered by pursx, a html-like format inspired by JSX.</p>
  <h2>Why Deku</h2>
  <ul>
    <li>It's fast.</li>
    <li>
      Well, that's about it for now... it's fast,
      but perhaps it has other advantages!
    </li>
  </ul>
  <p>
    <span style="font-weight:800;">Gratuitous demo alert:</span>
      click the button below to change the background of this div.
  </p>
  ~mybutton~
</div>
"""

main :: Effect Unit
main = unit 🚀 \_ _ -> psx px