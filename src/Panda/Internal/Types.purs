module Panda.Internal.Types where

import Control.Alternative      ((<|>))
import Control.Plus             (empty)
import Data.Algebra.Array       as Algebra.Array
import Data.Foldable            (foldl)
import Data.Generic.Rep         (class Generic)
import Data.Generic.Rep.Show    (genericShow)
import Data.Maybe               (Maybe)
import Data.String              as String
import Effect                   (Effect)
import FRP.Event                (Event) as FRP
import Web.Event.Internal.Types (Event) as DOM
import Unsafe.Coerce            (unsafeCoerce)

import Prelude

-- | Type signatures are really ugly for `update`, so we have this helpful
-- | little alias. Should you find a type error inside this, chances are that
-- | you have input/output/message/state wrong or mixed up.

type Updater input output message state
  = (output → Effect Unit)
  → ((state → { input ∷ input, state ∷ state }) → Effect Unit)
  → { message ∷ message, state ∷ state }
  → Effect Unit

-- | A component in Panda is a unit capable of running as an independent
-- | application. This is often not what you want, though, so `delegate` can be
-- | used to embed applications inside others, providing that we have a way to
-- | convert parent updates into child updates, and child events into parent
-- | messages.

type Component input output message state
  = { view         ∷ HTML input message state
    , subscription ∷ FRP.Event message
    , initial      ∷ { input ∷ input, state ∷ state }
    , update       ∷ Updater input output message state
    }

-- | Convenience type synonym for any update sets to HTML elements.

type HTMLUpdate input message state
  = Algebra.Array.Update (HTML input message state)

-- | Panda categorises HTML elements into four distinct types:
-- | - An `Element` is the regular element we all know and love: it has a tag
-- |   name, some properties, and some children. Its children are fixed.
-- | - A `Collection` is a regular element, with one small change: the children
-- |   of this element must be controlled via an update algebra.
-- | - `Text` is just that: a string of text that becomes a textFragment within
-- |   the DOM.
-- | - A `delegate` is a bit of a weird one, as it doesn't actually have its
-- |   own "HTML form". Instead, it is another Panda application embedded
-- |   within this one, and thus is rendered to be whatever is stored within
-- |   that element.

data HTML input message state

  = Element
      { tagName    ∷ String
      , properties ∷ Array (Property input message state)
      , children   ∷ Array (HTML input message state)
      }

  | Collection
      { tagName    ∷ String
      , properties ∷ Array (Property input message state)
      , watcher
          ∷ { input ∷ input, state ∷ state }
          → Array (HTMLUpdate input message state)
      }

  | Text String

  | Delegate (HTMLDelegateX input message)

-- | Before existentialising, a delegate is indexed by six types: all the types
-- | of the sub-application, plus the parent's input and message types. The
-- | idea here is that we map the `output` values of the _inner_ application to
-- | the `message` type of the _outer_ application, allowing us to handle
-- | events thrown within delegate applications.

newtype HTMLDelegate input message subinput suboutput submessage substate
  = HTMLDelegate
      { focus
          ∷ { input  ∷ input     → Maybe subinput
            , output ∷ suboutput → Maybe message
            }

      , application ∷ Component subinput suboutput submessage substate
      }

-- | An existentialised delegate is simply indexed by the input type and
-- | message type that, respectively, it can map from and to.

foreign import data HTMLDelegateX ∷ Type → Type → Type

-- | Rather than the rank-2 encoding, the transformation from a delegate to an
-- | existentialised delegate is just an unsafe coercion to "forget" those type
-- | variables.

mkHTMLDelegateX
  ∷ ∀ input message subinput suboutput submessage substate
  . HTMLDelegate input message subinput suboutput submessage substate
  → HTMLDelegateX input message

mkHTMLDelegateX
  = unsafeCoerce

-- | To unpack an existentialised delegate, we have to operate as though we
-- | have _no_ knowledge of the sub-application, and our only means of
-- | communicating with it are via the two functions supplied in the `focus`
-- | record. This process serves both to simplify the types _and_ prevent some
-- | obvious end user mistakes.

runHTMLDelegateX
  ∷ ∀ input message result
  . ( ∀ subinput suboutput submessage substate
    . HTMLDelegate input message subinput suboutput submessage substate
    → result
    )
  → HTMLDelegateX input message
  → result

runHTMLDelegateX f
  = f <<< unsafeCoerce

-- | A Panda property is simpler than an HTML element. Either we're some fixed
-- | value, some "event-triggering" value, or some dynamically-determined
-- | property based on the current input and state.

data Property input message state

  = Fixed
      { key   ∷ String
      , value ∷ String
      }

  | Producer
      { key     ∷ Producer
      , onEvent ∷ DOM.Event → Maybe message
      }

  | Dynamic
      ( { input ∷ input, state ∷ state }
      → ShouldUpdate (Property input message state)
      )

-- | Should we update? When a dynamic property receives an input, this algebra
-- | is used to convey whether or not to update its contents, or whether this
-- | update can just be ignored.

data ShouldUpdate a = Clear | Ignore | SetTo a

-- | Event-producing element properties. When assigning `Producer` properties,
-- | one of the following must be provided to specify the event to which you'd
-- | like to bind the action.

data Producer
  = OnBlur
  | OnChange
  | OnClick
  | OnDoubleClick
  | OnDrag
  | OnDragEnd
  | OnDragEnter
  | OnDragLeave
  | OnDragOver
  | OnDragStart
  | OnDrop
  | OnError
  | OnFocus
  | OnInput
  | OnKeyDown
  | OnKeyUp
  | OnMouseDown
  | OnMouseEnter
  | OnMouseLeave
  | OnMouseMove
  | OnMouseOver
  | OnMouseOut
  | OnMouseUp
  | OnSubmit

derive instance eqProducer  ∷ Eq Producer

-- | Convert a Producer to its html attribute name.

producerToAttribute = case _ of
  OnBlur        → "blur"
  OnChange      → "change"
  OnClick       → "click"
  OnDoubleClick → "doubleclick"
  OnDrag        → "drag"
  OnDragEnd     → "dragend"
  OnDragEnter   → "dragenter"
  OnDragLeave   → "dragleave"
  OnDragOver    → "dragover"
  OnDragStart   → "dragstart"
  OnDrop        → "drop"
  OnError       → "error"
  OnFocus       → "focus"
  OnInput       → "input"
  OnKeyDown     → "keydown"
  OnKeyUp       → "keyup"
  OnMouseDown   → "mousedown"
  OnMouseEnter  → "mouseenter"
  OnMouseLeave  → "mouseleave"
  OnMouseMove   → "mousemove"
  OnMouseOver   → "mouseover"
  OnMouseOut    → "mouseout"
  OnMouseUp     → "mouseup"
  OnSubmit      → "submit"

-- | An event system is the data structure that Panda uses internally to
-- | communicate properties of components. We can use this to cancel a system
-- | (thus removing properties, or children, from some dynamic piece), listen
-- | for events coming _out_ of a system, or push updates _into_ a system,
-- | allowing us full control. It's worth noting here that state is handled
-- | externally, which is not true of bootstrapped applications.

type EventSystem input message state
  = { cancel ∷ Effect Unit
    , events ∷ FRP.Event message
    , handleUpdate
        ∷ { input ∷ input
          , state ∷ state
          }
        → Effect Unit
    }

-- | Until I win my quest to make FRP.Event.(<>) equal to FRP.Event.(<|>), this
-- | system type will have to remain a semi-established monoid. We don't do
-- | _many_ event system combinations throughout the system, though, so this is
-- | more of a would-be-nice-in-the-future kind of change.

-- | An event system that does nothing and controls nothing.

emptySystem
  ∷ ∀ input message state
  . EventSystem input message state

emptySystem
  = { events: empty
    , handleUpdate: \_ → pure unit
    , cancel: pure unit
    }

-- | Combine two event systems into a single system that delegates to both of
-- | the input systems.

combineSystems
  ∷ ∀ input message state
  . EventSystem input message state
  → EventSystem input message state
  → EventSystem input message state

combineSystems this that
  = { cancel: do
        this.cancel
        that.cancel

    , handleUpdate: \update → do
        this.handleUpdate update
        that.handleUpdate update

    , events: this.events <|> that.events
    }

-- | Like `mconcat` for `EventSystem`.

foldSystems
  ∷ ∀ input message state
  . Array (EventSystem input message state)
  → EventSystem input message state

foldSystems
  = foldl combineSystems emptySystem
