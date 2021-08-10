module Data.Owoify.Internal.Util.Interleave where

import Prelude

import Data.Int (even)
import Data.List (List(..), null, (:))

-- | Utility function to interleave two lists.
interleave :: ∀ a. List a -> List a -> List a
interleave a b = go Nil a b 0
  where
    go result Nil other round      | even round = if not $ null other then other <> result else result
    go result (x : xs) other round | even round = go (x : result) xs other (round + 1)
    go result _ Nil _                           = result
    go result arr (x : xs) round                = go (x : result) arr xs (round + 1)