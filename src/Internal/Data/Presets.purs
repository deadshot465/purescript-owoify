module Data.Owoify.Internal.Data.Presets where

import Prelude

import Control.Monad.Except (ExceptT(..), except)
import Data.Array (toUnfoldable)
import Data.List (List)
import Data.Owoify.Internal.Data.Mappings as Mappings
import Data.Owoify.Internal.Entity.Word (Word)
import Effect (Effect)

specificWordMappingList :: List (Word -> ExceptT String Effect Word)
specificWordMappingList = toUnfoldable
  [ except <<< Mappings.mapFucToFwuc
  , except <<< Mappings.mapMomToMwom
  , except <<< Mappings.mapTimeToTim
  , except <<< Mappings.mapMeToMwe
  , except <<< Mappings.mapOverToOwor
  , except <<< Mappings.mapOveToUv
  , except <<< Mappings.mapHahaToHeheXd
  , except <<< Mappings.mapTheToTeh
  , except <<< Mappings.mapYouToU
  , except <<< Mappings.mapReadToWead
  , except <<< Mappings.mapWorseToWose
  , except <<< Mappings.mapGreatToGwate
  , except <<< Mappings.mapAviatToAwiat
  , except <<< Mappings.mapDedicatToDeditat
  , except <<< Mappings.mapRememberToRember
  , except <<< Mappings.mapWhenToWen
  , except <<< Mappings.mapFrightenedToFrigten
  , except <<< Mappings.mapMemeToMem
  , except <<< Mappings.mapFeelToFell
  ]

uvuMappingList :: List (Word -> ExceptT String Effect Word)
uvuMappingList = toUnfoldable
  [ ExceptT <<< Mappings.mapOToOwo
  , except <<< Mappings.mapEwToUwu
  , except <<< Mappings.mapHeyToHay
  , except <<< Mappings.mapDeadToDed
  , except <<< Mappings.mapNVowelTToNd
  ]

uwuMappingList :: List (Word → ExceptT String Effect Word)
uwuMappingList = toUnfoldable
  [ except <<< Mappings.mapBracketsToStartrails
  , ExceptT <<< Mappings.mapPeriodCommaExclamationSemicolonToKaomojis
  , except <<< Mappings.mapThatToDat
  , except <<< Mappings.mapThToF
  , except <<< Mappings.mapLeToWal
  , except <<< Mappings.mapVeToWe
  , except <<< Mappings.mapRyToWwy
  , except <<< Mappings.mapROrLToW
  ]

owoMappingList :: List (Word -> ExceptT String Effect Word)
owoMappingList = toUnfoldable
  [ except <<< Mappings.mapNVowelToNy
  , except <<< Mappings.mapLlToWw
  , except <<< Mappings.mapVowelOrRExceptOLToWl
  , except <<< Mappings.mapOldToOwld
  , except <<< Mappings.mapOlToOwl
  , except <<< Mappings.mapLOrROToWo
  , except <<< Mappings.mapSpecificConsonantsOToLetterAndWo
  , except <<< Mappings.mapVOrWLeToWal
  , except <<< Mappings.mapFiToFwi
  , except <<< Mappings.mapVerToWer
  , except <<< Mappings.mapPoiToPwoi
  , except <<< Mappings.mapSpecificConsonantsLeToLetterAndWal
  , except <<< Mappings.mapConsonantRToConsonantW
  , except <<< Mappings.mapLyToWy
  , except <<< Mappings.mapPleToPwe
  , except <<< Mappings.mapNrToNw
  , except <<< Mappings.mapMemToMwem
  , except <<< Mappings.unmapNywoToNyo
  ]