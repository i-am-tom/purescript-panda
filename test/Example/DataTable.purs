module Test.Example.DataTable where

import Control.Monad.Eff  (Eff)
import Control.Plus       (empty)
import Data.Algebra.Array as Algebra
import Data.Array         (sortWith)
import Data.Function      (on)
import Data.Maybe         (Maybe(..))

import Panda              as P
import Panda.HTML         as PH
import Panda.Property     as PP

import Prelude

newtype Event
  = SortSelected Header

type Queen
  = { name   ∷ String
    , age    ∷ Int
    , origin ∷ String
    , season ∷ Int
    }

type State
  = { rows        ∷ Array Queen
    , isAscending ∷ Boolean
    , header      ∷ Header
    }

type Updates eff
  = Array
      ( P.ComponentUpdate eff (Update eff) State Event
      )

data Update eff
  = RenderTable
  | UpdateTableRows (Updates eff)

data Header
  = Name
  | Age
  | Origin
  | Season

derive instance eqHeader ∷ Eq Header

rows ∷ Array Queen
rows
  = [ { name: "Victoria \"Porkchop\" Parker"
      , age: 47
      , origin: "Raleigh, North Carolina"
      , season: 1
      }

    , { name: "Tammie Brown"
      , age: 36
      , origin: "Los Angeles, California"
      , season: 1
      }

    , { name: "Akashia"
      , age: 32
      , origin: "Cleveland, Ohio"
      , season: 1
      }

    , { name: "Jade Sotomayor"
      , age: 32
      , origin: "Chicago, Illinois"
      , season: 1
      }

    , { name: "Ongina"
      , age: 26
      , origin: "Los Angeles, California"
      , season: 1
      }

    , { name: "Shannel"
      , age: 26
      , origin: "Las Vegas, Nevada"
      , season: 1
      }

    , { name: "Rebecca Glasscock"
      , age: 26
      , origin: "Fort Lauderdale, Florida"
      , season: 1
      }

    , { name: "Nina Flowers"
      , age: 34
      , origin: "Bayamón, Puerto Rico"
      , season: 1
      }

    , { name: "BeBe Zahara Benet"
      , age: 28
      , origin: "Minneapolis, Minnesota"
      , season: 1
      }

    , { name: "Shangela Laquifa Wadley"
      , age: 28
      , origin: "Paris, Texas"
      , season: 2
      }

    , { name: "Nicole Paige Brooks"
      , age: 36
      , origin: "Atlanta, Georgia"
      , season: 2
      }

    , { name: "Mystique Summers Madison"
      , age: 25
      , origin: "Chicago, Illinois"
      , season: 2
      }

    , { name: "Sonique"
      , age: 26
      , origin: "Atlanta, Georgia"
      , season: 2
      }

    , { name: "Morgan McMichaels"
      , age: 28
      , origin: "Mira Loma, California"
      , season: 2
      }

    , { name: "Sahara Davenport"
      , age: 25
      , origin: "New York, New York"
      , season: 2
      }

    , { name: "Jessica Wild"
      , age: 29
      , origin: "San Juan, Puerto Rico"
      , season: 2
      }

    , { name: "Pandora Boxx"
      , age: 37
      , origin: "Rochester, New York"
      , season: 2
      }

    , { name: "Tatianna"
      , age: 21
      , origin: "Falls Church, Virginia"
      , season: 2
      }

    , { name: "Jujubee"
      , age: 25
      , origin: "Boston, Massachusetts"
      , season: 2
      }

    , { name: "Raven"
      , age: 30
      , origin: "Riverside, California"
      , season: 2
      }

    , { name: "Tyra Sanchez"
      , age: 21
      , origin: "Orlando, Florida"
      , season: 2
      }

    , { name: "Venus D-Lite"
      , age: 26
      , origin: "Los Angeles, California"
      , season: 3
      }

    , { name: "Phoenix"
      , age: 29
      , origin: "Atlanta, Georgia"
      , season: 3
      }

    , { name: "Mimi Imfurst"
      , age: 27
      , origin: "New York, New York"
      , season: 3
      }

    , { name: "India Ferrah"
      , age: 23
      , origin: "Dayton, Ohio"
      , season: 3
      }

    , { name: "Mariah"
      , age: 29
      , origin: "Atlanta, Georgia"
      , season: 3
      }

    , { name: "Stacy Layne Matthews"
      , age: 25
      , origin: "Back Swamp, North Carolina"
      , season: 3
      }

    , { name: "Delta Work"
      , age: 34
      , origin: "Norwalk, California"
      , season: 3
      }

    , { name: "Shangela Laquifa Wadley"
      , age: 29
      , origin: "Paris, Texas"
      , season: 3
      }

    , { name: "Carmen Carrera"
      , age: 25
      , origin: "Elmwood Park, New Jersey"
      , season: 3
      }

    , { name: "Yara Sofia"
      , age: 26
      , origin: "Manatí, Puerto Rico"
      , season: 3
      }

    , { name: "Alexis Mateo"
      , age: 30
      , origin: "Saint Petersburg, Florida"
      , season: 3
      }

    , { name: "Manila Luzon"
      , age: 28
      , origin: "Cottage Grove, Minnesota"
      , season: 3
      }

    , { name: "Raja"
      , age: 36
      , origin: "Los Angeles, California"
      , season: 3
      }

    , { name: "Alisa Summers"
      , age: 23
      , origin: "Tampa, Florida"
      , season: 4
      }

    , { name: "Lashauwn Beyond"
      , age: 21
      , origin: "Fort Lauderdale, Florida"
      , season: 4
      }

    , { name: "The Princess"
      , age: 32
      , origin: "Chicago, Illinois"
      , season: 4
      }

    , { name: "Madame LaQueer"
      , age: 29
      , origin: "Carolina, Puerto Rico"
      , season: 4
      }

    , { name: "Milan"
      , age: 36
      , origin: "Florence, South Carolina"
      , season: 4
      }

    , { name: "Jiggly Caliente"
      , age: 30
      , origin: "Queens, New York"
      , season: 4
      }

    , { name: "Willam"
      , age: 29
      , origin: "Los Angeles, California"
      , season: 4
      }

    , { name: "DiDa Ritz"
      , age: 25
      , origin: "Chicago, Illinois"
      , season: 4
      }

    , { name: "Kenya Michaels"
      , age: 21
      , origin: "Dorado, Puerto Rico"
      , season: 4
      }

    , { name: "Latrice Royale"
      , age: 39
      , origin: "South Beach, Florida"
      , season: 4
      }

    , { name: "Phi Phi O'Hara"
      , age: 25
      , origin: "Chicago, Illinois"
      , season: 4
      }

    , { name: "Chad Michaels"
      , age: 40
      , origin: "San Diego, California"
      , season: 4
      }

    , { name: "Sharon Needles"
      , age: 29
      , origin: "Pittsburgh, Pennsylvania"
      , season: 4
      }

    , { name: "Penny Tration"
      , age: 39
      , origin: "Cincinnati, Ohio"
      , season: 5
      }

    , { name: "Serena ChaCha"
      , age: 21
      , origin: "Tallahassee, Florida"
      , season: 5
      }

    , { name: "Monica Beverly Hillz"
      , age: 27
      , origin: "Owensboro, Kentucky"
      , season: 5
      }

    , { name: "Honey Mahogany"
      , age: 29
      , origin: "San Francisco, California"
      , season: 5
      }

    , { name: "Vivienne Pinay"
      , age: 26
      , origin: "New York, New York"
      , season: 5
      }

    , { name: "Lineysha Sparx"
      , age: 24
      , origin: "San Juan, Puerto Rico"
      , season: 5
      }

    , { name: "Jade Jolie"
      , age: 25
      , origin: "Gainesville, Florida"
      , season: 5
      }

    , { name: "Ivy Winters"
      , age: 26
      , origin: "New York, New York"
      , season: 5
      }

    , { name: "Alyssa Edwards"
      , age: 32
      , origin: "Mesquite, Texas"
      , season: 5
      }

    , { name: "Coco Montrese"
      , age: 37
      , origin: "Las Vegas, Nevada"
      , season: 5
      }

    , { name: "Detox"
      , age: 27
      , origin: "Los Angeles, California"
      , season: 5
      }

    , { name: "Roxxxy Andrews"
      , age: 28
      , origin: "Orlando, Florida"
      , season: 5
      }

    , { name: "Alaska"
      , age: 27
      , origin: "Pittsburgh, Pennsylvania"
      , season: 5
      }

    , { name: "Jinkx Monsoon"
      , age: 24
      , origin: "Seattle, Washington"
      , season: 5
      }

    , { name: "Kelly Mantle"
      , age: 37
      , origin: "Los Angeles, California"
      , season: 6
      }

    , { name: "Magnolia Crawford"
      , age: 27
      , origin: "Seattle, Washington"
      , season: 6
      }

    , { name: "Vivacious"
      , age: 40
      , origin: "New York, New York"
      , season: 6
      }

    , { name: "April Carrión"
      , age: 24
      , origin: "Guaynabo, Puerto Rico"
      , season: 6
      }

    , { name: "Gia Gunn"
      , age: 23
      , origin: "Chicago, Illinois"
      , season: 6
      }

    , { name: "Milk"
      , age: 25
      , origin: "New York, New York"
      , season: 6
      }

    , { name: "Laganja Estranja"
      , age: 24
      , origin: "Van Nuys, California"
      , season: 6
      }

    , { name: "Trinity K. Bonet"
      , age: 22
      , origin: "Atlanta, Georgia"
      , season: 6
      }

    , { name: "Joslyn Fox"
      , age: 26
      , origin: "Worcester, Massachusetts"
      , season: 6
      }

    , { name: "BenDeLaCreme"
      , age: 31
      , origin: "Seattle, Washington"
      , season: 6
      }

    , { name: "Darienne Lake"
      , age: 41
      , origin: "Rochester, New York"
      , season: 6
      }

    , { name: "Courtney Act"
      , age: 31
      , origin: "West Hollywood, California"
      , season: 6
      }

    , { name: "Adore Delano"
      , age: 23
      , origin: "Azusa, California"
      , season: 6
      }

    , { name: "Bianca Del Rio"
      , age: 36
      , origin: "New Orleans, Louisiana"
      , season: 6
      }

    , { name: "Tempest DuJour"
      , age: 46
      , origin: "Tucson, Arizona"
      , season: 7
      }

    , { name: "Sasha Belle"
      , age: 28
      , origin: "Iowa City, Iowa"
      , season: 7
      }

    , { name: "Jasmine Masters"
      , age: 37
      , origin: "Los Angeles, California"
      , season: 7
      }

    , { name: "Mrs. Kasha Davis"
      , age: 43
      , origin: "Rochester, New York"
      , season: 7
      }

    , { name: "Kandy Ho"
      , age: 28
      , origin: "Cayey, Puerto Rico"
      , season: 7
      }

    , { name: "Max"
      , age: 22
      , origin: "Hudson, Wisconsin"
      , season: 7
      }

    , { name: "Jaidynn Diore Fierce"
      , age: 25
      , origin: "Nashville, Tennessee"
      , season: 7
      }

    , { name: "Miss Fame"
      , age: 29
      , origin: "New York, New York"
      , season: 7
      }

    , { name: "Trixie Mattel"
      , age: 26
      , origin: "Milwaukee, Wisconsin"
      , season: 7
      }

    , { name: "Katya"
      , age: 32
      , origin: "Boston, Massachusetts"
      , season: 7
      }

    , { name: "Kennedy Davenport"
      , age: 33
      , origin: "Dallas, Texas"
      , season: 7
      }

    , { name: "Pearl"
      , age: 23
      , origin: "Brooklyn, New York"
      , season: 7
      }

    , { name: "Ginger Minj"
      , age: 29
      , origin: "Orlando, Florida"
      , season: 7
      }

    , { name: "Violet Chachki"
      , age: 22
      , origin: "Atlanta, Georgia"
      , season: 7
      }

    , { name: "Laila McQueen"
      , age: 22
      , origin: "Gloucester, Massachusetts"
      , season: 8
      }

    , { name: "Dax ExclamationPoint"
      , age: 31
      , origin: "Savannah, Georgia"
      , season: 8
      }

    , { name: "Cynthia Lee Fontaine"
      , age: 34
      , origin: "Austin, Texas"
      , season: 8
      }

    , { name: "Naysha Lopez"
      , age: 31
      , origin: "Chicago, Illinois"
      , season: 8
      }

    , { name: "Acid Betty"
      , age: 37
      , origin: "Brooklyn, New York"
      , season: 8
      }

    , { name: "Robbie Turner"
      , age: 33
      , origin: "Seattle, Washington"
      , season: 8
      }

    , { name: "Thorgy Thor"
      , age: 31
      , origin: "Brooklyn, New York"
      , season: 8
      }

    , { name: "Derrick Barry"
      , age: 32
      , origin: "Las Vegas, Nevada"
      , season: 8
      }

    , { name: "Chi Chi DeVayne"
      , age: 30
      , origin: "Shreveport, Louisiana"
      , season: 8
      }

    , { name: "Naomi Smalls"
      , age: 21
      , origin: "Redlands, California"
      , season: 8
      }

    , { name: "Kim Chi"
      , age: 27
      , origin: "Chicago, Illinois"
      , season: 8
      }

    , { name: "Bob the Drag Queen"
      , age: 29
      , origin: "Brooklyn, New York"
      , season: 8
      }

    , { name: "Jaymes Mansfield"
      , age: 26
      , origin: "Madison, Wisconsin"
      , season: 9
      }

    , { name: "Kimora Blac"
      , age: 28
      , origin: "Las Vegas, Nevada"
      , season: 9
      }

    , { name: "Charlie Hides"
      , age: 52
      , origin: "London, UK"
      , season: 9
      }

    , { name: "Eureka O'Hara"
      , age: 25
      , origin: "Johnson City, Tennessee"
      , season: 9
      }

    , { name: "Cynthia Lee Fontaine"
      , age: 34
      , origin: "Austin, Texas"
      , season: 9
      }

    , { name: "Aja"
      , age: 22
      , origin: "Brooklyn, New York"
      , season: 9
      }

    , { name: "Farrah Moan"
      , age: 23
      , origin: "Las Vegas, Nevada"
      , season: 9
      }

    , { name: "Valentina"
      , age: 25
      , origin: "Los Angeles, California"
      , season: 9
      }

    , { name: "Nina Bo'nina Brown"
      , age: 34
      , origin: "Atlanta, Georgia"
      , season: 9
      }

    , { name: "Alexis Michelle"
      , age: 33
      , origin: "New York, New York"
      , season: 9
      }

    , { name: "Trinity Taylor"
      , age: 31
      , origin: "Orlando, Florida"
      , season: 9
      }

    , { name: "Shea Couleé"
      , age: 27
      , origin: "Chicago, Illinois"
      , season: 9
      }

    , { name: "Peppermint"
      , age: 37
      , origin: "New York, New York"
      , season: 9
      }

    , { name: "Sasha Velour"
      , age: 29
      , origin: "Brooklyn, New York"
      , season: 9
      }
    ]

view
  ∷ ∀ eff
  . P.Component eff (Update eff) State Event
view
  = PH.table_
      [ PH.thead_
          [ PH.tr_ $ headers <#> \{ text, header } ->
              PH.td
                [ PP.onClick \_ → Just (SortSelected header)
                ]

                [ PH.strong
                    [ PP.className' \{ state } →
                        if header /= state.header
                          then Nothing
                          else
                            Just if state.isAscending
                              then "highlight highlight--ascending"
                              else "highlight highlight--descending"
                    ]

                    [ PH.text text
                    ]
                ]
          ]

      , PH.tbody'_ $ P.DynamicChildren \{ update, state } →
          case update of
            RenderTable →
              state.rows <#> \{ name, age, origin, season } →
                Algebra.Push
                  $ PH.tr_
                      [ PH.td_ [ PH.text name          ]
                      , PH.td_ [ PH.text (show age)    ]
                      , PH.td_ [ PH.text origin        ]
                      , PH.td_ [ PH.text (show season) ]
                      ]

            UpdateTableRows instructions →
              instructions
      ]

  where
    headers
      = [ { text: "Name",   header: Name   }
        , { text: "Age",    header: Age    }
        , { text: "Origin", header: Origin }
        , { text: "Season", header: Season }
        ]

main
  ∷ ∀ eff
  . Eff (P.FX eff) Unit
main
  = void $ P.runApplication
      { view
      , subscription: empty
      , initial:
          { update: RenderTable
          , state:
              { header: Name
              , isAscending: true
              , rows: sortWith _.name rows
              }
          }

      , update: \dispatch { event: SortSelected selection, state } →
          let
            willAscend
              = selection /= state.header
                  || not state.isAscending

            cmp ∷ ∀ x. Ord x ⇒ x → x → Ordering
            cmp = if willAscend then compare else flip compare

            { state: rows, moves }
                = case selection of
                    Name   → PH.sortBy (cmp `on` _.name)   state.rows
                    Age    → PH.sortBy (cmp `on` _.age)    state.rows
                    Origin → PH.sortBy (cmp `on` _.origin) state.rows
                    Season → PH.sortBy (cmp `on` _.season) state.rows

            state'
              = { header: selection
                , isAscending: willAscend
                , rows: rows
                }
          in do
            dispatch \_ →
              { update: UpdateTableRows moves
              , state: state'
              }
      }
