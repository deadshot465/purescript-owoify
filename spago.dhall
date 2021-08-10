{ name = "owoify"
, license = "MIT"
, dependencies =
  [ "arrays"
  , "bifunctors"
  , "console"
  , "effect"
  , "either"
  , "foldable-traversable"
  , "integers"
  , "lists"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "random"
  , "strings"
  , "transformers"
  , "tuples"
  , "unfoldable"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, repository = "https://github.com/deadshot465/purescript-owoify"
}
