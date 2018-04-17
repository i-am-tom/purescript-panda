module Test.Example.DataTable where

-- | DATA TABLE

-- | A fairly common UI component: a data table shows some data and allows the
-- | user to sort (and reverse sort) its contents by clicking the headers. You
-- | can also filter the input by the search at the top.

import Control.Monad.Aff         (runAff_)
import Control.Monad.Eff         (Eff)
import Control.Monad.Eff.Class   (liftEff)
import Control.Monad.Eff.Console (logShow)
import Control.Plus              (empty)
import Data.Array                (sortWith)
import Data.Either               (either)
import Data.Foldable             (any)
import Data.Generic.Rep          (class Generic)
import Data.Generic.Rep.Show     (genericShow)
import Data.Monoid               (mempty)
import Data.String               (Pattern(..), contains, toLower)
import Effect                    (Effect)
import Network.HTTP.Affjax       (get)
import Simple.JSON               (readJSON)

import Panda                     as P
import Panda.HTML                as PH
import Panda.Property            as PP

import Panda.Prelude

-- | A queen's row is defined by her name, age at time of the given season, and
-- | the town from which she originates.

type Queen
  = { name   ∷ String
    , age    ∷ Int
    , origin ∷ String
    , season ∷ Int
    }

-- | Updates are sent from the `update function down to the DOM, and the DOM
-- | can react accordingly.

data Update
  = FilterTable String
  | RenderTable
  | UpdateTableRows (Array (PH.ComponentUpdate Update State Event))

-- | The state of this application. Note we don't include the search string, as
-- | it can exist within the updates alone.

type State
  = { rows        ∷ Array Queen
    , isAscending ∷ Boolean
    , header      ∷ Header
    }

-- | These are the events that occur within the table. We can either select a
-- | header to determine the sort, or enter a search string to filter.

data Event
  = SortSelected Header
  | SearchEntered String

-- | The headers that we show on the table.

data Header = Name | Age | Origin | Season
derive instance eqHeader ∷ Eq Header
derive instance genericHeader ∷ Generic Header _

instance showHeader ∷ Show Header where
  show = genericShow

headers ∷ Array Header
headers = [ Name, Age, Origin, Season ]

-- | Make a header in the data table.

makeTableHeader ∷ Header → PH.Component Update State Event
makeTableHeader header
  = PH.strong
      [ when (\u → u.state.header == header) \{ state } →
          PP.className if state.isAscending
            then "highlight--ascending"
            else "highlight--descending"
      ]

      [ PH.text (show header)
      ]

matches ∷ String → Queen → Boolean
matches search { name, age, origin, season }
  = any (contains ∘ Pattern ∘ toLower $ search)
      [ toLower name
      , show age
      , toLower origin
      , show season
      ]

-- | Render a single row in the data table.
renderRow ∷ ∀ state event. Queen → PH.Component Update state event
renderRow queen@{ name, age, origin, season }
  = PH.tr
      [ PP.when (const true) \{ update } →
          PP.className "hidden"
      ]

      [ PH.td_
          [ PH.text name
          ]

      , PH.td_
          [ PH.text age'
          ]

      , PH.td_
          [ PH.text origin
          ]

      , PH.td_
          [ PH.text season'
          ]
      ]
  where
    age'    = show age
    season' = show season

-- | The main view of our data table.
view ∷ PH.Component Update State Event
view
  = PH.section_
      [ PH.input
          [ PP.type_ "search"
          , PP.onInput' (Just ∘ SearchEntered)
          , PP.placeholder "Search..."
          ]

      , PH.table_
          [ PH.thead_
              [ PH.tr_ $ headers <#> \header ->
                  PH.td
                    [ PP.onClick \_ → Just (SortSelected header)
                    ]

                    [ makeTableHeader header
                    ]
              ]
          ]
      ]

-- | Updater for our state object.
updater ∷ P.Updater Update State Event
updater dispatch { event, state }
  = case event of
      SearchEntered input →
        dispatch
          { update: FilterTable input
          , state: _
          }

      SortSelected selection →
        let
          willAscend
            = selection /= state.header
                || not state.isAscending

          cmp ∷ ∀ x. Ord x ⇒ x → x → Ordering
          cmp = if willAscend then compare else flip compare

          { state: rows, moves }
              = state.rows # PH.sortBy case selection of
                  Name   → cmp `on` _.name
                  Age    → cmp `on` _.age
                  Origin → cmp `on` _.origin
                  Season → cmp `on` _.season

          state'
            = { header: selection
              , isAscending: willAscend
              , rows: []
              }
        in do
          dispatch \_ →
            { update: UpdateTableRows []
            , state: state'
            }

-- | The Panda application.
application ∷ Array Queen → Effect Unit
application queens
  = void $ P.runApplicationInBody
      { view
      , initial:
          { state:
              { header: Name
              , isAscending: true
              , rows: sortWith _.name queens
              }
          , update: RenderTable
          }
      , subscription: empty
      , update: updater
      }

-- | Run the actual application!
main ∷ Eff _ Unit
main = runAff_ mempty do
  queens ← get "Example/queens.json"

  case readJSON queens.response of
    Left error →
      liftEff (logShow error)

    Right result →
      liftEff
        ∘ effectToEff
        ∘ application
        $ result
