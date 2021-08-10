{ name = "my-project"
, dependencies =
  [ "aff"
  , "arrays"
  , "assert"
  , "bifunctors"
  , "console"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "integers"
  , "lists"
  , "maybe"
  , "node-buffer"
  , "node-fs-aff"
  , "prelude"
  , "psci-support"
  , "random"
  , "strings"
  , "transformers"
  , "tuples"
  , "unfoldable"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
