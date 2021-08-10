# purescript-owoify

Turning your worst nightmare into a PureScript package.

This is a PureScript port of [mohan-cao's owoify-js](https://github.com/mohan-cao/owoify-js), which will help you turn any string into nonsensical babyspeak similar to LeafySweet's infamous Chrome extension.

Just like my other Owoify ports, three levels of owoness are available. Each level has been implemented using a discriminated union, so it should work like enums people are used to seeing in other imperative languages.

1. **owo (default)**: The most vanilla one.
2. **uwu**: The moderate one.
3. **uvu**: Litewawwy unweadabwal.
Please refer to the original [owoify-js repository](https://github.com/mohan-cao/owoify-js) for more information.

Functional programming is fun, so of course I'll port it to FP languages. 😜

## Reason for development

While it's doable to just `npm install owoify-js` and use `foreign import` to bind to the original owoify-js in PureScript, you probably will need to do it every time and it also doesn't come with everything a pure functional language like PureScript offers. Plus, PureScript really hits a sweet spot between JS and FP, so it definitely deserves a dedicated owoify package.

## Install instructions

Either add `owoify` to your `spago.dhall`:

```dhall
{ name = "..."
, dependencies =
  [
    "owoify"
  ]
}
```

Or do this in command line:

```bash
spago install owoify
```

## Usage

purescript-owoify is implemented as a single function. You will need to provide a source string and a owoify level. Due to random number generator, the result will be inside `Effect`, so you will also need to handle that.

```purescript
module MyAwesomeModule where

import Prelude

import Data.Owoify.Owoify (OwoifyLevel(..), owoify)
import Effect (Effect)
import Effect.Class.Console (log)

main :: Effect Unit
main = do
  owoResult <- owoify "This is the string to owo! Kinda cute, isn't it?" Owo
  uvuResult <- owoify "This is the string to owo! Kinda cute, isn't it?" Uvu
  log owoResult
  log uvuResult
```

## Disclaimer

As usual, I'm writing this package for both practicing and bots' needs. Performance is **NOT** guaranteed.

For the time being, please do not try to owoify a long text (see `test/` folder for more details), since it would possibly cause stack overflow due to large monadic computation.

## See also

- [owoify-js](https://github.com/mohan-cao/owoify-js) - The original owoify-js repository.
- [Owoify.Net](https://www.nuget.org/packages/Owoify.Net/1.0.1) - The C# port of Owoify written by me.
- [Owoify++](https://github.com/deadshot465/OwoifyCpp) - The C++ header-only port of Owoify written by me.
- [owoify_rs](https://crates.io/crates/owoify_rs) - The Rust port of Owoify written by me.
- [owoify-py](https://pypi.org/project/owoify-py/) - The Python port of Owoify written by me.
- [owoify_dart](https://pub.dev/packages/owoify_dart) - The Dart port of Owoify written by me.
- [owoify_rb](https://rubygems.org/gems/owoify_rb) - The Ruby port of Owoify written by me.
- [owoify-go](https://github.com/deadshot465/owoify-go) - The Go port of Owoify written by me.
- [owoifySwift](https://github.com/deadshot465/OwoifySwift) - The Swift port of Owoify written by me.
- [owoifyKt](https://github.com/deadshot465/owoifyKt) - The Kotlin port of Owoify written by me.
- [owoify_ex](https://github.com/deadshot465/owoify_ex) - The Elixir port of Owoify written by me.
- [owoify_cr](https://github.com/deadshot465/owoify_cr) - The Crystal port of Owoify written by me.
- [owoifynim](https://github.com/deadshot465/owoifynim) - The Nim port of Owoify written by me.
- [owoify-clj](https://clojars.org/net.clojars.deadshot465/owoify-clj) - The Clojure port of Owoify written by me.

## License

MIT License

Copyright (c) 2021 Chehui Chou

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.