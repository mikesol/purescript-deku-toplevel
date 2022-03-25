module Test.Main where

import Prelude hiding (compare)

import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec (describe, it)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)

main :: Effect Unit
main = launchAff_ $ runSpec [ consoleReporter ] do
  describe "Tests" do
    it "Should exist, but doesn't... see the example!" do
      pure unit