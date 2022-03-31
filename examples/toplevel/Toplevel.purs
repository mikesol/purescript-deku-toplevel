module Deku.Example.Toplevel where

import Prelude

import Deku.Pursx (psx)
import Deku.Toplevel ((🚀))
import Effect (Effect)
import Type.Proxy (Proxy(..))

px = Proxy :: Proxy  """
<div>
  <h1>Hello!</h1>
  <p>This is what a no-frills deku app looks like.</p>
</div>
"""

main :: Effect Unit
main = unit 🚀 \_ _ -> psx px