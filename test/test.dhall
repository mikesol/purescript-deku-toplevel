let conf = ../spago.dhall
in conf //
  { dependencies =
      conf.dependencies #
        [ "spec"
        , "aff"
        ]
  , sources =
      conf.sources #
        [ "test/**/*.purs"
        ]
  }
