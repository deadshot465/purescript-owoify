module Data.Owoify.Owoify
  ( owoify
  , uwuify
  , uvuify
  , OwoifyLevel(..)
  )
  where
  
import Prelude

import Control.Monad.Except (ExceptT)
import Data.Array.NonEmpty (toUnfoldable)
import Data.Bifunctor (rmap)
import Data.Either (Either(..))
import Data.List (List(..), intercalate, length, reverse, uncons)
import Data.Maybe (Maybe(..))
import Data.Owoify.Internal.Data.Presets (owoMappingList, specificWordMappingList, uvuMappingList, uwuMappingList)
import Data.Owoify.Internal.Data.RegexFlags (globalFlags)
import Data.Owoify.Internal.Entity.Word (Word)
import Data.Owoify.Internal.Parser.OwoifyParser (OError, OwoifyParser, count, runOwoifyParser)
import Data.Owoify.Internal.Util.Interleave (interleave)
import Data.String.Regex (match, regex)
import Data.Traversable (class Traversable, sequence)
import Data.Tuple (Tuple(..))
import Data.Unfoldable (class Unfoldable)
import Effect (Effect)
import Effect.Class.Console (error)

-- | Levels to denote owoness.
data OwoifyLevel = Owo | Uwu | Uvu

extractWords :: ∀ t
  . Traversable t
  => Unfoldable t
  => String
  -> String
  -> Either String (Maybe (t String))
extractWords pattern s =
  regex pattern globalFlags <#> (\r -> case match r s of
    Nothing -> Nothing
    Just arr -> sequence $ toUnfoldable arr)

words :: String -> Either String (Maybe (List String))
words = extractWords "[^\\s]+"

spaces :: String -> Either String (Maybe (List String))
spaces = extractWords "\\s+"

logIfError :: ∀ a. Either String (Maybe (List a)) -> Effect (List a)
logIfError = case _ of
  Left err -> do
    error err
    pure Nil
  Right arr -> case arr of
    Nothing -> do
      error "Source string cannot be empty."
      pure Nil
    Just a -> pure a

mapResult :: ∀ a. Either a a -> a
mapResult (Left err) = err
mapResult (Right res) = res

buildParsers ::
  Int
  -> List (Word → ExceptT String Effect Word)
  -> OwoifyParser OError List (List (Effect (Either String Word)))
buildParsers n = count uncons n

-- | `owoify source level` will owoify source string using the specified level.
-- | Currently three levels are supported, from weak to strong: `Owo`, `Uwu`, `Uvu`
owoify :: String -> OwoifyLevel -> Effect String
owoify source level = do
  w <- logIfError $ words source
  s <- logIfError $ spaces source
  let n = length w
  let parsers = buildParsers n $ specificWordMappingList <> case level of
        Owo -> owoMappingList
        Uwu -> uwuMappingList <> owoMappingList
        Uvu -> uvuMappingList <> uwuMappingList <> owoMappingList
  let result = runOwoifyParser parsers w :: Either OError _
  case result of
    Left err -> do
      error $ show err
      pure ""
    Right (Tuple _ transformedWords) -> do
      wordsList <- sequence transformedWords >>= pure <<< map (rmap show)
      spacesList <- pure $ Right <$> s
      let interleavedArray = reverse $ mapResult <$> interleave wordsList spacesList
      pure $ intercalate "" interleavedArray

uwuify ∷ String → Effect String
uwuify source = owoify source Uwu

uvuify ∷ String → Effect String
uvuify source = owoify source Uvu