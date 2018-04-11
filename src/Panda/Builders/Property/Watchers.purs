module Panda.Builders.Property.Watchers where

import Data.Identity  (Identity(..))
import Data.Maybe     (Maybe(..))
import Panda.Internal as I

import Prelude

makeDynamic
  ∷ ∀ update state event
  . ( { state ∷ state, update ∷ update }
    → Maybe Boolean
    )
  → I.Property update state event
  → I.Property update state event
watch predicate
  = case _ of
      I.StaticProperty (Fixed { key, value: Identity value }) →
        DynamicProperty $ Fixed
          { key
          , value: DynamicF $ predicate >>> case _ of
              Just update →
                I.ShouldUpdate if update
                  then I.Set value
                  else I.Delete

              Nothing →
                I.Ignore
          }

-- | Render a property whenever a predicate holds, and remove it whenever it
-- | doesn't. If possible, use `updateWhen` as a less expensive alternative.

renderWhen
  ∷ ∀ update state event
  . Partial
  ⇒ ({ state ∷ state, update ∷ update } → Boolean)
  → I.Property update state event
  → I.Property update state event

renderWhen predicate
  = case _ of
      I.StaticProperty property →
        case property of
          I.Fixed { key, value: Identity value } →
            I.DynamicProperty $ I.Fixed
              { key
              , value: I.DynamicF \update →
                  if predicate update
                    then Just value
                    else Nothing
              }

PP.className "isAscending" `renderWhen` _.state.isAscending

PP.className `updateWhen` case _ of
  { update: ReorderList, state: { isAscending: true } } →
      I.Rerender (Set "is-ascending")
  { update: ReorderList, state: { isAscending: false } } →
      I.Rerender (Set "is-descending")
  _ →
      I.Ignore

I.Dynamicproperty $ I.Fixed
  { key: "className"
  , value: I.DynamicF \update →
      if update.state.is

PP.className `updateWhen` \{ update, state: { header, isAscending } } →
  case update of
    ReorderList →
      if header == my.header
        then Rerender if isAscending
          then "ascending"
          else "descending"
