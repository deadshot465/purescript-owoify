module Data.Owoify.Internal.Data.RegexFlags where

import Data.String.Regex.Flags (RegexFlags(..))
  
defaultFlags :: RegexFlags  
defaultFlags = RegexFlags
  { dotAll: false
  , global: false
  , ignoreCase: false
  , multiline: false
  , sticky: false
  , unicode: true
  }

globalFlags :: RegexFlags
globalFlags = RegexFlags
  { dotAll: false
  , global: true
  , ignoreCase: false
  , multiline: false
  , sticky: false
  , unicode: true
  }