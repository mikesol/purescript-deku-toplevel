{ name = "purescript-deku-toplevel"
, dependencies =
  [ "deku"
  , "effect"
  , "either"
  , "event"
  , "foldable-traversable"
  , "maybe"
  , "prelude"
  , "tuples"
  , "web-dom"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
