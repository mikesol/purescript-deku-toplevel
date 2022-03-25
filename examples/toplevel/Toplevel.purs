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
      ( (Proxy :: _ "<div ~mydiv~>hello!</div>") ~!
          { mydiv: D.div'attr [ D.OnClick := cb (const $ push unit) ]
          }
      )
  ) 🚀
     \_ -> const $ change
        { "root.psx.mydiv": D.div'attr
            [ D.Style := "background-color: rgb(65,72,109);" ]
        }
