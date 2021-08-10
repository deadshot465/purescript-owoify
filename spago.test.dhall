let main = ./spago.dhall

in { name = "purescript-owoify-tests"
   , dependencies = main.dependencies # [ "aff", "assert", "node-buffer", "node-fs-aff" ]
   , packages = ./packages.dhall
   , sources = main.sources # [ "test/**/*.purs" ]
   }
