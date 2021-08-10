module Data.Owoify.Internal.Entity.Word
  ( replace
  , replaceWithFuncSingle
  , replaceWithFuncMultiple
  , Word(..)
  )
  where

import Prelude

import Data.Array (head, toUnfoldable)
import Data.Array.NonEmpty.Internal (NonEmptyArray(..))
import Data.Either (Either(..))
import Data.List (List, any, nub)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Owoify.Internal.Data.RegexFlags (globalFlags)
import Data.String (Pattern(..), Replacement(..), replace) as String
import Data.String (trim)
import Data.String.Regex (Regex, match, regex, source, test)
import Data.String.Regex as Regex

foreign import _matchAll :: Regex -> String -> Array (Array String)

-- | Basic type for manipulating strings.
newtype Word = Word
  { innerWord :: String
  , innerReplacedWords :: List String
  }

instance showWord :: Show Word where
  show (Word { innerWord }) = innerWord

data Triple = Triple String String String

testAndGetReplacingWord :: Regex -> String -> String -> String
testAndGetReplacingWord searchValue replaceValue str =
  if test searchValue str then
    case match searchValue str of
      Nothing -> str
      Just (NonEmptyArray [ Just s' ]) -> String.replace (String.Pattern s') (String.Replacement replaceValue) str
      Just _ -> str
  else str

containsReplacedWords :: Word -> Regex -> String -> Boolean
containsReplacedWords (Word { innerReplacedWords }) searchValue replaceValue =
  any (\s -> if test searchValue s then
    case match searchValue s of
      Nothing -> false
      Just (NonEmptyArray [ Just s' ]) -> String.replace (String.Pattern s') (String.Replacement replaceValue) s == s
      Just _ -> false else false) innerReplacedWords

buildCollection :: Regex -> String -> Either String (Array String)
buildCollection searchValue str = 
  (flip _matchAll str >=> pure <<< fromMaybe "" <<< head) <$> (source searchValue # flip regex globalFlags)

buildReplacedWords :: String -> Either String (Array String) -> Array String
buildReplacedWords replaceValue = case _ of
  Left s -> [ s ]
  Right arr ->
    (\s -> String.replace (String.Pattern s) (String.Replacement replaceValue) s) <$> arr

-- | `replace word searchValue replaceValue replaceReplacedWords` will match the `word` against `searchValue` and replace matched strings with `replaceValue`.
replace :: Word -> Regex -> String -> Boolean -> Word
replace word@(Word { innerWord, innerReplacedWords }) searchValue replaceValue replaceReplacedWords
  | not replaceReplacedWords && containsReplacedWords word searchValue replaceValue = word
  | otherwise = if replacingWord == innerWord then word else Word { innerWord: replacingWord, innerReplacedWords: nub $ innerReplacedWords <> (toUnfoldable replacedWords) }
      where
        replacingWord = if test searchValue innerWord then trim $ Regex.replace searchValue replaceValue innerWord else innerWord
        collection = buildCollection searchValue innerWord
        replacedWords = buildReplacedWords replaceValue collection

-- | `replaceWithFuncSingle word searchValue f replaceReplacedWords` will match the `word` against `searchValue` and replace matched strings with the string resulting from invoking `f`.
replaceWithFuncSingle :: Word -> Regex -> (Unit -> String) -> Boolean -> Word
replaceWithFuncSingle word@(Word { innerWord, innerReplacedWords }) searchValue f replaceReplacedWords =
  if not replaceReplacedWords && containsReplacedWords word searchValue replaceValue then word
  else
    if replacingWord == innerWord then word else Word { innerWord: replacingWord, innerReplacedWords: nub $ innerReplacedWords <> (toUnfoldable replacedWords) }
      where
        replaceValue = f unit 
        replacingWord = trim $ testAndGetReplacingWord searchValue replaceValue innerWord
        collection = buildCollection searchValue innerWord
        replacedWords = buildReplacedWords replaceValue collection

-- | `replaceWithFuncMultiple word searchValue f replaceReplacedWords` will match the `word` against `searchValue` and replace matched strings with the string resulting from invoking `f`.
-- | The difference between this and `replaceWithFuncSingle` is that the `f` here takes two `String` arguments.
replaceWithFuncMultiple :: Word -> Regex -> (String -> String -> String) -> Boolean -> Word
replaceWithFuncMultiple word@(Word { innerWord, innerReplacedWords }) searchValue f replaceReplacedWords
  | not test searchValue innerWord = word
  | otherwise =
      if not replaceReplacedWords && containsReplacedWords word searchValue replaceValue then word
      else
        if replacingWord == innerWord then word else Word { innerWord: replacingWord, innerReplacedWords: nub $ innerReplacedWords <> (toUnfoldable replacedWords) }
        where
          matchItem = match searchValue innerWord
          Triple s1 s2 s3 = case matchItem of
            Nothing -> Triple innerWord innerWord innerWord
            Just (NonEmptyArray [ Just s1, Just s2, Just s3 ]) -> Triple s1 s2 s3
            Just _ -> Triple innerWord innerWord innerWord
          replaceValue = f s2 s3
          replacingWord = trim $ String.replace (String.Pattern s1) (String.Replacement replaceValue) innerWord
          collection = buildCollection searchValue innerWord
          replacedWords = buildReplacedWords replaceValue collection
