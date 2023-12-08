module Data.Owoify.Internal.Data.Mappings
  ( mapBracketsToStartrails
  , mapConsonantRToConsonantW
  , mapDeadToDed
  , mapEwToUwu
  , mapFiToFwi
  , mapFucToFwuc
  , mapHahaToHeheXd
  , mapHeyToHay
  , mapLeToWal
  , mapLlToWw
  , mapLOrROToWo
  , mapLyToWy
  , mapMeToMwe
  , mapMomToMwom
  , mapNrToNw
  , mapMemToMwem
  , unmapNywoToNyo
  , mapNVowelTToNd
  , mapNVowelToNy
  , mapOldToOwld
  , mapOlToOwl
  , mapOToOwo
  , mapOveToUv
  , mapOverToOwor
  , mapPeriodCommaExclamationSemicolonToKaomojis
  , mapPleToPwe
  , mapPoiToPwoi
  , mapReadToWead
  , mapROrLToW
  , mapRyToWwy
  , mapSpecificConsonantsLeToLetterAndWal
  , mapSpecificConsonantsOToLetterAndWo
  , mapThatToDat
  , mapTheToTeh
  , mapThToF
  , mapTimeToTim
  , mapVerToWer
  , mapVeToWe
  , mapVOrWLeToWal
  , mapVowelOrRExceptOLToWl
  , mapWorseToWose
  , mapYouToU
  , mapGreatToGwate
  , mapAviatToAwiat
  , mapDedicatToDeditat
  , mapRememberToRember
  , mapWhenToWen
  , mapFrightenedToFrigten
  , mapMemeToMem
  , mapFeelToFell
  )
  where

import Prelude

import Data.Array (length, (!!))
import Data.Either (Either)
import Data.Maybe (fromMaybe)
import Data.Owoify.Internal.Data.RegexFlags (defaultFlags)
import Data.Owoify.Internal.Entity.Word (Word, replace, replaceWithFuncMultiple, replaceWithFuncSingle)
import Data.String (toUpper)
import Data.String.Regex (Regex, regex)
import Effect (Effect)
import Effect.Random (randomInt)

oToOwo :: Either String Regex
oToOwo = regex "o" defaultFlags

ewToUwu :: Either String Regex
ewToUwu = regex "ew" defaultFlags

heyToHay :: Either String Regex
heyToHay = regex "([Hh])ey" defaultFlags

deadToDedUpper :: Either String Regex
deadToDedUpper = regex "Dead" defaultFlags

deadToDedLower :: Either String Regex
deadToDedLower = regex "dead" defaultFlags

nVowelTToNd :: Either String Regex
nVowelTToNd = regex "n[aeiou]*t" defaultFlags

readToWeadUpper :: Either String Regex
readToWeadUpper = regex "Read" defaultFlags

readToWeadLower :: Either String Regex
readToWeadLower = regex "read" defaultFlags

bracketsToStartrailsFore :: Either String Regex
bracketsToStartrailsFore = regex "[({<]" defaultFlags

bracketsToStartrailsRear :: Either String Regex
bracketsToStartrailsRear = regex "[)}>]" defaultFlags

periodCommaExclamationSemicolonToKaomojisFirst :: Either String Regex
periodCommaExclamationSemicolonToKaomojisFirst = regex "[.,](?![0-9])" defaultFlags

periodCommaExclamationSemicolonToKaomojisSecond :: Either String Regex
periodCommaExclamationSemicolonToKaomojisSecond = regex "[!;]+" defaultFlags

thatToDatUpper :: Either String Regex
thatToDatUpper = regex "That" defaultFlags

thatToDatLower :: Either String Regex
thatToDatLower = regex "that" defaultFlags

thToFUpper :: Either String Regex
thToFUpper = regex "TH(?!E)" defaultFlags

thToFLower :: Either String Regex
thToFLower = regex "[Tt]h(?![Ee])" defaultFlags

leToWal :: Either String Regex
leToWal = regex "le$" defaultFlags

veToWeUpper :: Either String Regex
veToWeUpper = regex "Ve" defaultFlags

veToWeLower :: Either String Regex
veToWeLower = regex "ve" defaultFlags

ryToWwy :: Either String Regex
ryToWwy = regex "ry" defaultFlags

rOrLToWUpper :: Either String Regex
rOrLToWUpper = regex "(?:R|L)" defaultFlags

rOrLToWLower :: Either String Regex
rOrLToWLower = regex "(?:r|l)" defaultFlags

llToWw :: Either String Regex
llToWw = regex "ll" defaultFlags

vowelOrRExceptOLToWlUpper :: Either String Regex
vowelOrRExceptOLToWlUpper = regex "[AEIUR]([lL])$" defaultFlags

vowelOrRExceptOLToWlLower :: Either String Regex
vowelOrRExceptOLToWlLower = regex "[aeiur]l$" defaultFlags

oldToOwldUpper :: Either String Regex
oldToOwldUpper = regex "OLD" defaultFlags

oldToOwldLower :: Either String Regex
oldToOwldLower = regex "([Oo])ld" defaultFlags

olToOwlUpper :: Either String Regex
olToOwlUpper = regex "OL" defaultFlags

olToOwlLower :: Either String Regex
olToOwlLower = regex "([Oo])l" defaultFlags

lOrROToWoUpper :: Either String Regex
lOrROToWoUpper = regex "[LR]([oO])" defaultFlags

lOrROToWoLower :: Either String Regex
lOrROToWoLower = regex "[lr]o" defaultFlags

specificConsonantsOToLetterAndWoUpper :: Either String Regex
specificConsonantsOToLetterAndWoUpper = regex "([BCDFGHJKMNPQSTXYZ])([oO])" defaultFlags

specificConsonantsOToLetterAndWoLower :: Either String Regex
specificConsonantsOToLetterAndWoLower = regex "([bcdfghjkmnpqstxyz])o" defaultFlags

vOrWLeToWal :: Either String Regex
vOrWLeToWal = regex "[vw]le" defaultFlags

fiToFwiUpper :: Either String Regex
fiToFwiUpper = regex "FI" defaultFlags

fiToFwiLower :: Either String Regex
fiToFwiLower = regex "([Ff])i" defaultFlags

verToWer :: Either String Regex
verToWer = regex "([Vv])er" defaultFlags

poiToPwoi :: Either String Regex
poiToPwoi = regex "([Pp])oi" defaultFlags

specificConsonantsLeToLetterAndWal :: Either String Regex
specificConsonantsLeToLetterAndWal = regex "([DdFfGgHhJjPpQqRrSsTtXxYyZz])le$" defaultFlags

consonantRToConsonantW :: Either String Regex
consonantRToConsonantW = regex "([BbCcDdFfGgKkPpQqSsTtWwXxZz])r" defaultFlags

lyToWyUpper :: Either String Regex
lyToWyUpper = regex "Ly" defaultFlags

lyToWyLower :: Either String Regex
lyToWyLower = regex "ly" defaultFlags

pleToPwe :: Either String Regex
pleToPwe = regex "([Pp])le" defaultFlags

nrToNwUpper :: Either String Regex
nrToNwUpper = regex "NR" defaultFlags

nrToNwLower :: Either String Regex
nrToNwLower = regex "([Nn])r" defaultFlags

memToMwemUpper ∷ Either String Regex
memToMwemUpper = regex "Mem" defaultFlags

memToMwemLower ∷ Either String Regex
memToMwemLower = regex "mem" defaultFlags

nywoToNyo ∷ Either String Regex
nywoToNyo = regex "([Nn])ywo" defaultFlags

funcToFwuc :: Either String Regex
funcToFwuc = regex "([Ff])uc" defaultFlags

momToMwom :: Either String Regex
momToMwom = regex "([Mm])om" defaultFlags

meToMweUpper :: Either String Regex
meToMweUpper = regex "^Me$" defaultFlags

meToMweLower ∷ Either String Regex
meToMweLower = regex "^me$" defaultFlags

nVowelToNyFirst :: Either String Regex
nVowelToNyFirst = regex "n([aeiou])" defaultFlags

nVowelToNySecond :: Either String Regex
nVowelToNySecond = regex "N([aeiou])" defaultFlags

nVowelToNyThird :: Either String Regex
nVowelToNyThird = regex "N([AEIOU])" defaultFlags

oveToUvUpper :: Either String Regex
oveToUvUpper = regex "OVE" defaultFlags

oveToUvLower :: Either String Regex
oveToUvLower = regex "ove" defaultFlags

hahaToHeheXd :: Either String Regex
hahaToHeheXd = regex "\\b(ha|hah|heh|hehe)+\\b" defaultFlags

theToTeh :: Either String Regex
theToTeh = regex "\\b([Tt])he\\b" defaultFlags

youToUUpper :: Either String Regex
youToUUpper = regex "\\bYou\\b" defaultFlags

youToULower :: Either String Regex
youToULower = regex "\\byou\\b" defaultFlags

timeToTim :: Either String Regex
timeToTim = regex "\\b([Tt])ime\\b" defaultFlags

overToOwor :: Either String Regex
overToOwor = regex "([Oo])ver" defaultFlags

worseToWose :: Either String Regex
worseToWose = regex "([Ww])orse" defaultFlags

greatToGwate ∷ Either String Regex
greatToGwate = regex "([Gg])reat" defaultFlags

aviatToAwiat ∷ Either String Regex
aviatToAwiat = regex "([Aa])viat" defaultFlags

dedicatToDeditat ∷ Either String Regex
dedicatToDeditat = regex "([Dd])edicat" defaultFlags

rememberToRember ∷ Either String Regex
rememberToRember = regex "([Rr])emember" defaultFlags

whenToWen ∷ Either String Regex
whenToWen = regex "([Ww])hen" defaultFlags

frightenedToFrigten ∷ Either String Regex
frightenedToFrigten = regex "([Ff])righten(ed)*" defaultFlags

memeToMemFirst ∷ Either String Regex
memeToMemFirst = regex "Meme" defaultFlags

memeToMemSecond ∷ Either String Regex
memeToMemSecond = regex "Mem" defaultFlags

feelToFell ∷ Either String Regex
feelToFell = regex "^([Ff])eel$" defaultFlags

faces :: Array String
faces =
  [ "(・`ω´・)"
  , ";;w;;"
  , "owo"
  , "UwU"
  , ">w<"
  , "^w^"
  , "(* ^ ω ^)"
  , "(⌒ω⌒)"
  , "ヽ(*・ω・)ﾉ"
  , "(o´∀`o)"
  ,"(o･ω･o)"
  , "＼(＾▽＾)／"
  , "(*^ω^)"
  , "(◕‿◕✿)"
  , "(◕ᴥ◕)"
  , "ʕ•ᴥ•ʔ"
  , "ʕ￫ᴥ￩ʔ"
  , "(*^.^*)"
  , "(｡♥‿♥｡)"
  , "OwO"
  , "uwu"
  , "uvu"
  , "UvU"
  , "(*￣з￣)"
  , "(つ✧ω✧)つ"
  , "(/ =ω=)/"
  , "(╯°□°）╯︵ ┻━┻"
  ,"┬─┬ ノ( ゜-゜ノ)"
  , "¯\\_(ツ)_/¯"
  ]

mapOToOwo :: Word -> Effect (Either String Word)
mapOToOwo word = do
  n <- randomInt 0 1
  let emoji = if n > 0 then "owo" else "o"
  pure $ (\r -> replace word r emoji false) <$> oToOwo

mapEwToUwu :: Word -> Either String Word
mapEwToUwu word = (\r -> replace word r "uwu" false) <$> ewToUwu

mapHeyToHay :: Word -> Either String Word
mapHeyToHay word = (\r -> replace word r "$1ay" false) <$> heyToHay

mapDeadToDed :: Word -> Either String Word
mapDeadToDed word = do
  w <- (\r -> replace word r "Ded" false) <$> deadToDedUpper
  (\r -> replace w r "ded" false) <$> deadToDedLower

mapNVowelTToNd :: Word -> Either String Word
mapNVowelTToNd word = (\r -> replace word r "nd" false) <$> nVowelTToNd

mapReadToWead :: Word -> Either String Word
mapReadToWead word = do
  w <- (\r -> replace word r "Wead" false) <$> readToWeadUpper
  (\r -> replace w r "wead" false) <$> readToWeadLower

mapBracketsToStartrails :: Word -> Either String Word
mapBracketsToStartrails word = do
  w <- (\r -> replace word r "｡･:*:･ﾟ★,｡･:*:･ﾟ☆" false) <$> bracketsToStartrailsFore
  (\r -> replace w r "☆ﾟ･:*:･｡,★ﾟ･:*:･｡" false) <$> bracketsToStartrailsRear

mapPeriodCommaExclamationSemicolonToKaomojis :: Word -> Effect (Either String Word)
mapPeriodCommaExclamationSemicolonToKaomojis word = do
  n <- randomInt 0 $ (length faces - 1)
  let face = fromMaybe "" $ faces !! n
  let w = (\r -> replaceWithFuncSingle word r (const face) false) <$> periodCommaExclamationSemicolonToKaomojisFirst
  n' <- randomInt 0 $ (length faces - 1)
  let face' = fromMaybe "" $ faces !! n'
  pure $ (\r w' ->
    replaceWithFuncSingle w' r (const face') false)
    <$> periodCommaExclamationSemicolonToKaomojisSecond
    <*> w

mapThatToDat :: Word -> Either String Word
mapThatToDat word = do
  w <- (\r -> replace word r "dat" false) <$> thatToDatLower
  (\r -> replace w r "Dat" false) <$> thatToDatUpper

mapThToF :: Word -> Either String Word
mapThToF word = do
  w <- (\r -> replace word r "f" false) <$> thToFLower
  (\r -> replace w r "F" false) <$> thToFUpper

mapLeToWal :: Word -> Either String Word
mapLeToWal word = (\r -> replace word r "wal" false) <$> leToWal

mapVeToWe :: Word -> Either String Word
mapVeToWe word = do
  w <- (\r -> replace word r "we" false) <$> veToWeLower
  (\r -> replace w r "We" false) <$> veToWeUpper

mapRyToWwy :: Word -> Either String Word
mapRyToWwy word = (\r -> replace word r "wwy" false) <$> ryToWwy

mapROrLToW :: Word -> Either String Word
mapROrLToW word = do
  w <- (\r -> replace word r "w" false) <$> rOrLToWLower
  (\r -> replace w r "W" false) <$> rOrLToWUpper

mapLlToWw :: Word -> Either String Word
mapLlToWw word = (\r -> replace word r "ww" false) <$> llToWw

mapVowelOrRExceptOLToWl :: Word -> Either String Word
mapVowelOrRExceptOLToWl word = do
  w <- (\r -> replace word r "wl" false) <$> vowelOrRExceptOLToWlLower
  (\r -> replace w r "W$1" false) <$> vowelOrRExceptOLToWlUpper

mapOldToOwld :: Word -> Either String Word
mapOldToOwld word = do
  w <- (\r -> replace word r "$1wld" false) <$> oldToOwldLower
  (\r -> replace w r "OWLD" false) <$> oldToOwldUpper

mapOlToOwl :: Word -> Either String Word
mapOlToOwl word = do
  w <- (\r -> replace word r "$1wl" false) <$> olToOwlLower
  (\r -> replace w r "OWL" false) <$> olToOwlUpper

mapLOrROToWo :: Word -> Either String Word
mapLOrROToWo word = do
  w <- (\r -> replace word r "wo" false) <$> lOrROToWoLower
  (\r -> replace w r "W$1" false) <$> lOrROToWoUpper

mapSpecificConsonantsOToLetterAndWo :: Word -> Either String Word
mapSpecificConsonantsOToLetterAndWo word = do
  w <- (\r -> replace word r "$1wo" false) <$> specificConsonantsOToLetterAndWoLower
  (\r -> replaceWithFuncMultiple w r (\c1 c2 -> c1 <> (if toUpper c2 == c2 then "W" else "w") <> c2) false) <$> specificConsonantsOToLetterAndWoUpper

mapVOrWLeToWal :: Word -> Either String Word
mapVOrWLeToWal word = (\r -> replace word r "wal" false) <$> vOrWLeToWal

mapFiToFwi :: Word -> Either String Word
mapFiToFwi word = do
  w <- (\r -> replace word r "$1wi" false) <$> fiToFwiLower
  (\r -> replace w r "FWI" false) <$> fiToFwiUpper

mapVerToWer :: Word -> Either String Word
mapVerToWer word = (\r -> replace word r "wer" false) <$> verToWer

mapPoiToPwoi :: Word -> Either String Word
mapPoiToPwoi word = (\r -> replace word r "$1woi" false) <$> poiToPwoi

mapSpecificConsonantsLeToLetterAndWal :: Word -> Either String Word
mapSpecificConsonantsLeToLetterAndWal word =
  (\r -> replace word r "$1wal" false) <$> specificConsonantsLeToLetterAndWal

mapConsonantRToConsonantW :: Word -> Either String Word
mapConsonantRToConsonantW word =
  (\r -> replace word r "$1w" false) <$> consonantRToConsonantW

mapLyToWy :: Word -> Either String Word
mapLyToWy word = do
  w <- (\r -> replace word r "wy" false) <$> lyToWyLower
  (\r -> replace w r "Wy" false) <$> lyToWyUpper

mapPleToPwe :: Word -> Either String Word
mapPleToPwe word = (\r -> replace word r "$1we" false) <$> pleToPwe

mapNrToNw :: Word -> Either String Word
mapNrToNw word = do
  w <- (\r -> replace word r "$1w" false) <$> nrToNwLower
  (\r -> replace w r "NW" false) <$> nrToNwUpper

mapMemToMwem :: Word -> Either String Word
mapMemToMwem word = do
  w <- (\r -> replace word r "mwem" false) <$> memToMwemUpper
  (\r -> replace w r "Mwem" false) <$> memToMwemLower

unmapNywoToNyo ∷ Word → Either String Word
unmapNywoToNyo word = (\r -> replace word r "$1yo" false) <$> nywoToNyo

mapFucToFwuc :: Word -> Either String Word
mapFucToFwuc word = (\r -> replace word r "$1wuc" false) <$> funcToFwuc

mapMomToMwom :: Word -> Either String Word
mapMomToMwom word = (\r -> replace word r "$1wom" false) <$> momToMwom

mapMeToMwe :: Word -> Either String Word
mapMeToMwe word = do
  w <- (\r -> replace word r "Mwe" false) <$> meToMweUpper
  (\r -> replace w r "mwe" false) <$> meToMweLower

mapNVowelToNy :: Word -> Either String Word
mapNVowelToNy word = do
  w <- (\r -> replace word r "ny$1" false) <$> nVowelToNyFirst
  w' <- (\r -> replace w r "Ny$1" false) <$> nVowelToNySecond
  (\r -> replace w' r "NY$1" false) <$> nVowelToNyThird

mapOveToUv :: Word -> Either String Word
mapOveToUv word = do
  w <- (\r -> replace word r "uv" false) <$> oveToUvLower
  (\r -> replace w r "UV" false) <$> oveToUvUpper

mapHahaToHeheXd :: Word -> Either String Word
mapHahaToHeheXd word = (\r -> replace word r "hehe xD" false) <$> hahaToHeheXd

mapTheToTeh :: Word -> Either String Word
mapTheToTeh word = (\r -> replace word r "$1eh" false) <$> theToTeh

mapYouToU :: Word -> Either String Word
mapYouToU word = do
  w <- (\r -> replace word r "U" false) <$> youToUUpper
  (\r -> replace w r "u" false) <$> youToULower

mapTimeToTim :: Word -> Either String Word
mapTimeToTim word = (\r -> replace word r "$1im" false) <$> timeToTim

mapOverToOwor :: Word -> Either String Word
mapOverToOwor word = (\r -> replace word r "$1wor" false) <$> overToOwor

mapWorseToWose :: Word -> Either String Word
mapWorseToWose word = (\r -> replace word r "$1ose" false) <$> worseToWose

mapGreatToGwate ∷ Word → Either String Word
mapGreatToGwate word = (\r -> replace word r "$1wate" false) <$> greatToGwate

mapAviatToAwiat ∷ Word → Either String Word
mapAviatToAwiat word = (\r -> replace word r "$1wiat" false) <$> aviatToAwiat

mapDedicatToDeditat ∷ Word → Either String Word
mapDedicatToDeditat word = (\r -> replace word r "$1editat" false) <$> dedicatToDeditat

mapRememberToRember ∷ Word → Either String Word
mapRememberToRember word = (\r -> replace word r "$1ember" false) <$> rememberToRember

mapWhenToWen ∷ Word → Either String Word
mapWhenToWen word = (\r -> replace word r "$1en" false) <$> whenToWen

mapFrightenedToFrigten ∷ Word → Either String Word
mapFrightenedToFrigten word = (\r -> replace word r "$1rigten" false) <$> frightenedToFrigten

mapMemeToMem ∷ Word → Either String Word
mapMemeToMem word = do
  w <- (\r -> replace word r "mem" false) <$> memeToMemFirst
  (\r -> replace w r "Mem" false) <$> memeToMemSecond

mapFeelToFell ∷ Word → Either String Word
mapFeelToFell word = (\r -> replace word r "$1ell" false) <$> feelToFell