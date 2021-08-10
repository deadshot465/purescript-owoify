module Data.Owoify.Owoify
  ( owoify
  , OwoifyLevel(..)
  )
  where
  
import Prelude

import Data.Array.NonEmpty (toUnfoldable)
import Data.Bifunctor (rmap)
import Data.Either (Either(..))
import Data.List (List(..), intercalate, length, reverse, uncons)
import Data.Maybe (Maybe(..))
import Data.Owoify.Internal.Data.Presets (owoMappingList, specificWordMappingList, uvuMappingList, uwuMappingList)
import Data.Owoify.Internal.Data.RegexFlags (globalFlags)
import Data.Owoify.Internal.Entity.Word (Word(..))
import Data.Owoify.Internal.Parser.OwoifyParser (OError, OwoifyParser, count, runOwoifyParser)
import Data.Owoify.Internal.Util.Interleave (interleave)
import Data.String.Regex (match, regex)
import Data.Traversable (sequence)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Class.Console (error)

data OwoifyLevel = Owo | Uwu | Uvu

words :: String -> Either String (Maybe (List Word))
words s =
  regex "[^\\s]+" globalFlags <#> (\r -> case match r s of
    Nothing -> Nothing
    Just arr -> sequence $ map (\s' -> Word { innerWord: s', innerReplacedWords: Nil }) <$> toUnfoldable arr)

spaces :: String -> Either String (Maybe (List Word))
spaces s = 
  regex "\\s+" globalFlags <#> (\r -> case match r s of
    Nothing -> Nothing
    Just arr -> sequence $ map (\s' -> Word { innerWord: s', innerReplacedWords: Nil }) <$> toUnfoldable arr)

logIfError :: Either String (Maybe (List Word)) -> Effect (List Word)
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

owoify :: String -> OwoifyLevel -> Effect String
owoify source level = do
  w <- logIfError $ words source
  s <- logIfError $ spaces source
  let n = length w
  let parsers = case level of
        Owo -> count uncons n (specificWordMappingList <> owoMappingList) :: OwoifyParser OError List (List (Effect (Either String Word)))
        Uwu -> count uncons n (specificWordMappingList <> uwuMappingList <> owoMappingList)
        Uvu -> count uncons n (specificWordMappingList <> uvuMappingList <> uwuMappingList <> owoMappingList)
  let result = runOwoifyParser parsers (show <$> w) :: Either OError _
  case result of
    Left err -> do
      error $ show err
      pure ""
    Right (Tuple _ transformedWords) -> do
      wordsList <- sequence transformedWords
      spacesList <- pure $ Right <$> s
      let interleavedArray = reverse $ mapResult <$> rmap show <$> interleave wordsList spacesList
      pure $ intercalate "" interleavedArray