# Release notes

DeckKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` updates.
* Breaking changes should not occur in `minor` and `patch` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if needed.

These release notes only cover the current major version. 



## 1.5.2

### 🐛 Bug Fixes

* `CardView` fixes the content rotation of the back view.



## 1.5.1

This version makes `DeckViewConfiguration` conform to `Sendable`.



## 1.5

This version deprecates the `DeckItem` protocol and only uses `Identifiable`.

### ✨ Features

* `DeckView` now has a `stateAnimation` for all state changes.
* `DeckView` now applies a `bouncy` state animation by default.
* `DeckView` now has a single `swipeAction` for all directions.

### 🚨 Important

* The `CardView` no longer applies a corner radius to its views.

### 🗑️ Deprecations

* The `Card` view is renamed to `CardView`.
* The `Color.card` color has been deprecated.
* The `DeckItem` protocol has been deprecated.
* The `Equatable` extensions have been deprecated.



## 1.4

This version makes the SDK use Swift 6.



## 1.3

This version has breaking changes for the favorite context/service setup, to make favorites easier to use.

Favorite contexts are now created with a service, and shares the type. This however requires that both types are generic.

### ✨ New features

* `Card` is a new view, with a front and back view and flip support.

### 🗑️ Deprecations

* `Configuration` has been converted to an `Equatable` extension.
* `View` `deckShuffleAnimation` has been converted to an internal modifier.

### 💥 Breaking Changes

* The favorite types have cleaned up their generic designed to be easier to use.



## 1.2.1

This version makes the library build even without strict concurrency checks enabled.

This makes the library once again build with Xcode 15.2 and earlier.



## 1.2

This version adds support for strict concurrency checks.

### ✨ New features

* `DeckViewConfiguration` is now applied with a view modifier instead of with the initializer.

### 💡 Adjustments

* `DeckShuffleAnimation` now supports strict concurrency.

### 🐛 Bug Fixes

* `DeckShuffleAnimation` now animates the new cards nicely to the new end state.



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
