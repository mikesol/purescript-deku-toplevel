{ name = "purescript-deku-toplevel"
, dependencies =
  [ "deku"
  , "effect"
  , "either"
  , "event"
  , "foldable-traversable"
  , "prelude"
  , "tuples"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
