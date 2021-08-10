module Test.Main where

import Prelude

import Data.Foldable (traverse_)
import Data.Owoify.Owoify (OwoifyLevel(..), owoify)
import Data.String (Pattern(..), split)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (readTextFile)
import Test.Assert (assert)

source :: String
source = "Hello World! This is the string to owo! Kinda cute, isn't it?"

pokemonNamesListPath :: String
pokemonNamesListPath = "assets/pokemons.txt"

warAndPeacePath :: String
warAndPeacePath = "assets/war_and_peace_chapter01-20.txt"

testOwoify :: Effect Unit
testOwoify = do
  result <- owoify source Owo
  assert $ result /= source

testOwo :: Effect Unit
testOwo = do
  result <- owoify source Owo
  assert $ result /= mempty

testUwu :: Effect Unit
testUwu = do
  result <- owoify source Uwu
  assert $ result /= mempty

testUvu :: Effect Unit
testUvu = do
  result <- owoify source Uvu
  assert $ result /= mempty

testOwoNotEqualToUwu :: Effect Unit
testOwoNotEqualToUwu = do
  owoResult <- owoify source Owo
  uwuResult <- owoify source Uwu
  assert $ owoResult /= uwuResult

testOwoNotEqualToUvu :: Effect Unit
testOwoNotEqualToUvu = do
  owoResult <- owoify source Owo
  uvuResult <- owoify source Uvu
  assert $ owoResult /= uvuResult

testUwuNotEqualToUvu :: Effect Unit
testUwuNotEqualToUvu = do
  uwuResult <- owoify source Uwu
  uvuResult <- owoify source Uvu
  assert $ uwuResult /= uvuResult

testPokemonNameWithLevel :: String -> OwoifyLevel -> Effect Unit
testPokemonNameWithLevel name level = do
  result <- owoify name level
  assert $ result /= ""

testPokemonNames :: String -> Effect Unit
testPokemonNames pokemonNames = do
  pokemonNameList <- pure $ split (Pattern " ") pokemonNames
  log "---- Test Pokemon Names with Owo"
  traverse_ (liftEffect <<< flip testPokemonNameWithLevel Owo) pokemonNameList
  log "---- Test Pokemon Names with Uwu"
  traverse_ (liftEffect <<< flip testPokemonNameWithLevel Uwu) pokemonNameList
  log "---- Test Pokemon Names with Uvu"
  traverse_ (liftEffect <<< flip testPokemonNameWithLevel Uvu) pokemonNameList

testLongText :: String -> Effect Unit
testLongText longText = do
  log "---- Test Long Text with Owo"
  owoLongText <- owoify longText Owo
  assert $ owoLongText /= longText
  assert $ owoLongText /= ""
  log "---- Test Long Text with Uwu"
  uwuLongText <- owoify longText Uwu
  assert $ uwuLongText /= longText
  assert $ uwuLongText /= ""
  log "---- Test Long Text with Uvu"
  uvuLongText <- owoify longText Uvu
  assert $ uvuLongText /= longText
  assert $ uvuLongText /= ""

main :: Effect Unit
main = do
  log "-- Test Owoify"
  testOwoify
  log "-- Test Owo"
  testOwo
  log "-- Test Uwu"
  testUwu
  log "-- Test Uvu"
  testUvu
  log "-- Test Owo Not Equal To Uwu"
  testOwoNotEqualToUwu
  log "-- Test Owo Not Equal To Uvu"
  testOwoNotEqualToUvu
  log "-- Test Uwu Not Equal To Uvu"
  testUwuNotEqualToUvu
  launchAff_ do
    log "-- Test Pokemon Names"
    pokemonNames <- readTextFile UTF8 pokemonNamesListPath
    liftEffect $ testPokemonNames pokemonNames
    -- TODO: This will cause stack overflow.
    {- log "-- Test Long Text"
    longText <- readTextFile UTF8 warAndPeacePath
    liftEffect $ testLongText longText -}
  pure unit