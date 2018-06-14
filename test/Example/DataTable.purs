module Test.Example.DataTable where

-- | DATA TABLE

-- | A fairly common UI component: a data table shows some data and allows the
-- | user to sort (and reverse sort) its contents by clicking the headers. You
-- | can also filter the input by the search at the top.

import Control.Plus                 (empty)
import Data.Algebra.Array           as Algebra
import Data.Array                   (sortWith)
import Data.Either                  (Either(..))
import Data.Foldable                (any)
import Data.Function                (on)
import Data.Generic.Rep             (class Generic)
import Data.Generic.Rep.Show        (genericShow)
import Data.Maybe                   (Maybe(..))
import Data.String                  (Pattern(..), contains, toLower)
import Effect                       (Effect)
import Effect.Aff                   (runAff_)
import Effect.Class                 (liftEffect)
import Effect.Console               (logShow)
import Network.HTTP.Affjax          (get)
import Network.HTTP.Affjax.Response (string)
import Simple.JSON                  (readJSON)

import Panda                     as P
import Panda.HTML                as PH
import Panda.Property            as PP

import Debug.Trace (spy)
import Prelude

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
  | UpdateTableRows (Array (PH.HTMLUpdate Update Event State))

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

makeTableHeader ∷ Header → PH.HTML Update Event State
makeTableHeader header
  = PH.strong
      [ PP.when (\u → u.state.header == header) \{ state } →
          PP.className if state.isAscending
            then "highlight--ascending"
            else "highlight--descending"
      ]

      [ PH.text (show header)
      ]

matches ∷ String → Queen → Boolean
matches search { name, age, origin, season }
  = any (contains $ Pattern $ toLower search)
      [ toLower name
      , show age
      , toLower origin
      , show season
      ]

-- | Render a single row in the data table.
renderRow ∷ Queen → PH.HTML Update Event State
renderRow queen@{ name, age, origin, season }
  = PH.tr
      [ PP.watch \{ input } →
          case input of
            FilterTable str →
              spy "hello?" if str `matches` queen
                then P.Clear
                else P.SetTo (PP.className "hidden")
            _ →
              P.Ignore
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
view ∷ PH.HTML Update Event State
view
  = PH.section_
      [ PH.input
          [ PP.type_ "search"
          , PP.onInput' (Just <<< SearchEntered)
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

          , PH.tbody'_ \{ input, state } →
              case input of
                RenderTable →
                  map (Algebra.Push <<< renderRow) state.rows

                UpdateTableRows moves →
                  moves

                _ →
                  []
          ]
      ]

-- | Updater for our state object.
updater ∷ P.Updater Update Void Event State
updater emit dispatch { message, state }
  = dispatch \_ → case message of
      SearchEntered input →
        { input: FilterTable input
        , state
        }

      SortSelected header →
        let
          cmp ∷ ∀ x. Ord x ⇒ x → x → Ordering
          cmp = if isAscending then compare else flip compare

          isAscending = header /= state.header || not state.isAscending

          comparator = case header of
            Name   → cmp `on` _.name
            Age    → cmp `on` _.age
            Origin → cmp `on` _.origin
            Season → cmp `on` _.season

          { state: rows, moves } = PH.sortBy comparator state.rows

        in
          { input: UpdateTableRows moves
          , state: { header, isAscending, rows }
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
          , input: RenderTable
          }
      , subscription: empty
      , update: updater
      }

-- | Run the actual application!
main ∷ Effect Unit
main = runAff_ mempty do
  queens ← get string "Example/queens.json"

  case readJSON queens.response of
    Left error →
      liftEffect (logShow error)

    Right result →
      liftEffect
        $ application
        $ result
