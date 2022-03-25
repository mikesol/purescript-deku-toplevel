module Deku.Toplevel where

import Prelude

import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.Tuple.Nested ((/\), type (/\))
import Deku.Control.Functions ((@>))
import Deku.Control.Monadic (MDOM)
import Deku.Create (class Create)
import Deku.Graph.DOM (Root, root, Element)
import Deku.Interpret (makeFFIDOMSnapshot)
import Deku.Run (RunEngine, RunDOM, defaultOptions, run)
import Effect (Effect)
import FRP.Event (subscribe)
import Prim.Row (class Nub)
import Web.HTML (window)
import Web.HTML.HTMLDocument (body)
import Web.HTML.HTMLElement (toElement)
import Web.HTML.Window (document)

runInBody
  :: forall push sn graph control
   . Create (root :: Element Root sn) () graph
  => Nub graph graph
  => ( (push -> Effect Unit) -> { | sn } /\ control
     )
  -> ( forall proofB
        . push
       -> control
       -> MDOM RunDOM RunEngine proofB Unit graph control
     )
  -> Effect Unit
runInBody scene loop = do
  b' <- window >>= document >>= body
  for_ (toElement <$> b') \elt -> do
    ffi <- makeFFIDOMSnapshot
    subscribe
      ( run (pure unit) (pure unit) defaultOptions ffi
          $
            ( \_ push ->
                let sn /\ ctrl = scene push in root elt sn /\ ctrl
            ) @> \env ctrl -> case env of
              Left _ -> pure ctrl
              Right push -> loop push ctrl
      )
      (_.res >>> pure)

infix 1 runInBody as 🚀