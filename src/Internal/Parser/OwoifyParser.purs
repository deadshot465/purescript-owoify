module Data.Owoify.Internal.Parser.OwoifyParser
  ( class OwoifyError
  , count
  , eof
  , OError(..)
  , OwoifyParser
  , parseError
  , runOwoifyParser
  ) where

import Prelude

import Control.Monad.Except (ExceptT, runExceptT)
import Data.Either (Either(..))
import Data.Foldable (class Foldable, foldM)
import Data.Generic.Rep (class Generic)
import Data.List (List(..))
import Data.Maybe (Maybe(..))
import Data.Owoify.Internal.Entity.Word (Word(..))
import Data.Show.Generic (genericShow)
import Data.Traversable (class Traversable, sequence)
import Data.Tuple (Tuple(..))
import Data.Unfoldable (class Unfoldable, none, replicate)
import Effect (Effect)

-- | The `OwoifyError` class represents those types denoting errors when owoifying.
class OwoifyError e where
  -- | Representing that the source collection of strings has been exhausted.
  eof :: e
  -- | Representing general parser error. Currently not used.
  parseError :: String -> e

-- | A simple type representing errors that occur during owoification.
data OError = EOF | ParseError String

derive instance genericOError :: Generic OError _

instance showOError :: Show OError where
  show = genericShow

instance owoifyErrorOError :: OwoifyError OError where
  eof = EOF
  parseError = ParseError

type OwoifyResult f a = Tuple (f String) a

type OwoifyFunction e f a = OwoifyError e => f String -> Either e (OwoifyResult f a)

newtype OwoifyParser e f a = OwoifyParser (OwoifyFunction e f a)

instance functorOwoifyParser :: Functor (OwoifyParser e f) where
  map f (OwoifyParser g) = OwoifyParser $ map (map f) <<< g

instance applyOwoifyParser :: Apply (OwoifyParser e f) where
  apply (OwoifyParser f) (OwoifyParser g) = OwoifyParser $ \s -> do
    Tuple s' ab <- f s
    Tuple s'' a <- g s'
    pure $ Tuple s'' (ab a)

instance applicativeOwoifyParser :: Applicative (OwoifyParser e f) where
  pure x = OwoifyParser \s -> pure $ Tuple s x

instance bindOwoifyParser :: Bind (OwoifyParser e f) where
  bind (OwoifyParser f) g = OwoifyParser $ f >=> \(Tuple s a) -> runOwoifyParser (g a) s

instance monadOwoifyParser :: Monad (OwoifyParser e f)

-- | `runOwoifyParser (OwoifyParser f)` simply executes (unwraps) the parser inside the monad.
runOwoifyParser :: ∀ e f a. OwoifyError e => OwoifyParser e f a -> OwoifyFunction e f a
runOwoifyParser (OwoifyParser f) = f

runReduce :: ∀ f
  . Foldable f
  => Word
  -> f (Word -> ExceptT String Effect Word)
  -> Effect (Either String Word)
runReduce w mappings = runExceptT $ foldM (#) w $ mappings

word :: ∀ e f
  . OwoifyError e
  => Foldable f
  => (f String -> Maybe { head :: String, tail :: f String })
  -> f (Word -> ExceptT String Effect Word)
  -> OwoifyParser e f (Effect (Either String Word))
word unconsFunc mappings = OwoifyParser \s -> do
  case unconsFunc s of
    Nothing -> Left eof
    Just { head, tail } -> do
      let w = Word { innerWord: head, innerReplacedWords: Nil }
      let result = runReduce w mappings
      Right $ Tuple tail result

-- | `count unconsFunc n p` will replicate owoify parser according to the specified `uncons`, length (`n`) and a collection of owoify functions. 
count :: ∀ f e
  . OwoifyError e
  => Foldable f
  => Traversable f
  => Unfoldable f
  => (f String -> Maybe { head :: String, tail :: f String })
  -> Int
  -> f (Word -> ExceptT String Effect Word)
  -> OwoifyParser e f (f (Effect (Either String Word)))
count unconsFunc n p | n <= 0 = pure none
                     | otherwise = sequence (replicate n $ word unconsFunc p)