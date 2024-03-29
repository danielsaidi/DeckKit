# Release notes


## 1.1

This version adds support for visionOS.

This minor update also rolls back the environment changes in 1.0.1.

The configuration is once more init injected and not through the environment. The environment injection will be implemented in a major version instead.

### ✨ New features

* `DeckView` now has a shuffle animation init parameter.
* `DeckViewConfiguration` has a new `modified` function.

### 💡 Behavior changes

* `DeckItem` is now a typalias, not a `protocol`.

### 🗑️ Deprecations

* `Deck` is no longer needed, you can just use plain arrays instead.
* `DeckContext` is no longer needed since `Deck` is also deprecated.
* `Favoritable` is no longer needed, you can just use `Identifiable`.

### 💥 Breaking Changes

* The `DeckViewConfiguration` environment change has been rolled back.



## 1.0.1

This patch adds support for visionOS and environment keys.

It also adjustes the default direction of the ``DeckView``, from `.up` to `.down`.

### ✨ New features

* `DeckViewConfiguration.Key` is a new environment key.
* `View` has a `.deckViewConfiguration` modifier that you can use to apply a custom view configuration.

### 💡 Behavior changes

* `DeckViewConfiguration` now uses `.down` as the default direction.



## 1.0

DeckKit now targets iOS 15.0, macOS 11.0, tvOS 15.0 and watchOS 8.0.

### ✨ New features

* `DeckPageView` is a new horizontal page view.



## 0.8

DeckKit now targets Swift 5.9.

### 🐛 Bug Fixes

* `DeckShuffleAnimation` now properly triggers `isShuffling`.



## 0.7.1

### ✨ New features

* `Deck` has new `move` functions.



## 0.7

### ✨ New features

* `Deck` has a new `shuffle` function.
* `DeckShuffleAnimation` is a new animation.
* `DeckView` has a new convenience initializer.



## 0.6

### ✨ New features

This version adds an additional `DeckView` initializer so that you don't have to specify the `itemViewBuilder` parameter name.

### 💥 Breaking Changes

* All previously deprecated code has been removed.
* `DeckView` `itemViewBuilder` has been renamed to `itemView`.



## 0.5

### 💡 Behavior changes

* `DeckView` action parameters are now optional.
* `DeckView` card builder no longer requires `AnyView`.

### 🗑️ Deprecations

* `BasicCard` has been deprecated and will be removed in 0.6.
* `HorizontalDeck` has been deprecated and will be removed in 0.6.
* `StackedDeck` has been renamed to `DeckView`.
* `StackedDeck` has a new `itemViewBuilder` initializer.
* `StackedDeckConfiguration` has been renamed to `DeckViewConfiguration`.
* `StackedDeckConfiguration` has a new `itemDisplayCount` initializer.

### 💥 Breaking Changes

* `BasicCard` no longer applies a fixed width to its content.
* `HorizontalDeck` no longer contains a scroll view.



## 0.4

### ✨ New features

* `StackedDeck` uses a new `StackedDeckConfiguration`.
* `StackedDeckConfiguration` has a `.standard` value that is automatically used.

### 💡 Behavior changes

* `StackedDeck` no longer changes the card offset value within an animation.

### 💥 Breaking Changes

* `StackedDeck` now takes a configuration as init parameter instead of separate values.



## 0.3

### ✨ New features

* `Deck` now lets you specify id.

### 💥 Breaking Changes

* `BasicItem` has been renamed to `BasicCard.Item`.
* `CardItem` has been renamed to `DeckItem`.



## 0.2

The `deck` init params for `StackedDeck` and `HorizontalDeck` has been changed to a binding.

This gives you better control over the deck, removes UI glitches and helped me remove a bunch of state for visible cards in `StackDeck`, which means that deck modifications now instantly trigger UI changes. 

I have added a shuffle button to the demo to demonstrate how much better the stacked deck performs.

The `StackedDeck` has been improved in more ways:

* I have changed the order of how the vertical offset and scale effect are applied, which fixes a UI glitch.
* I have added `swipeLeft/Right/Up/Down` actions which let you trigger actions depending on how a user swipes a card of the top of the deck.

The `DeckContext` class is still in the library, but is not used by the library itself.



## 0.1.1

This version was just made to force the CocoaPod to pass validation. 



## 0.1

This version is the first public release of DeckKit. 

It contains components that are used in apps that have been pushed to production, which is why I decided to release it as a first minor.
