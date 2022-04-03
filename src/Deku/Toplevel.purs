module Deku.Toplevel where

import Prelude

import Data.Maybe (maybe)
import Deku.Control (deku)
import Deku.Core (Element)
import Deku.Interpret (FFIDOMSnapshot, effectfulDOMInterpret, makeFFIDOMSnapshot)
import Effect (Effect)
import FRP.Event (Event, create, subscribe)
import Web.DOM.Element as Web.DOM
import Web.HTML (window)
import Web.HTML.HTMLDocument (body)
import Web.HTML.HTMLElement (toElement)
import Web.HTML.Window (document)

runInElement
  :: forall push
   . Web.DOM.Element
  -> push
  -> ( (push -> Effect Unit)
       -> Event push
       -> Element Event (FFIDOMSnapshot -> Effect Unit)
     )
  -> Effect Unit
runInElement elt psh mksn = void $ runInElement' elt psh mksn

runInElement'
  :: forall push
   . Web.DOM.Element
  -> push
  -> ( (push -> Effect Unit)
       -> Event push
       -> Element Event (FFIDOMSnapshot -> Effect Unit)
     )
  -> Effect (Effect Unit)
runInElement' elt psh mksn = do
  ffi <- makeFFIDOMSnapshot
  { push, event } <- create
  let evt = deku elt (mksn push event) effectfulDOMInterpret
  sub <- subscribe evt \i -> i ffi
  push psh
  pure sub

runInBody'
  :: forall push
   . push
  -> ( (push -> Effect Unit)
       -> Event push
       -> Element Event (FFIDOMSnapshot -> Effect Unit)
     )
  -> Effect (Effect Unit)
runInBody' push go = do
  b' <- window >>= document >>= body
  maybe (pure (pure unit)) (\elt -> runInElement' elt push go) (toElement <$> b')

runInBody
  :: forall push
   . push
  -> ( (push -> Effect Unit)
       -> Event push
       -> Element Event (FFIDOMSnapshot -> Effect Unit)
     )
  -> Effect Unit
runInBody push go = void $ runInBody' push go

infix 1 runInBody as 🚀
infix 1 runInBody' as 🚆
