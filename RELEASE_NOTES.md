# Release notes

[DeckKit](https://github.com/danielsaidi/DeckKit) uses semantic versioning with the following strategy:

* Deprecations can happen in any version.
* Deprecations are only removed in `major` updates.
* Breaking changes must only occur in `major` updates.
* Breaking changes *can* occur in non-major updates, if the alternative is worse.



## 3.1

This version deprecates the favorite tools, to keep the package light and focused.

This version also renames back some types to shorter names, to align better with native SwiftUI types like `List` and `Grid`.

### 🗑️ Deprecations

* The `CardView` has been renamed to `Card`.
* The `DeckView` has been renamed to `Deck`.
* The `DeckViewConfiguration` has been renamed to `DeckConfiguration`.
* The favorite tools will be moved to [SwiftUIKit](https://github.com/danielsaidi/SwiftUIKit).



## 3.0

The package now targets iOS 17 and aligned platform versions.

This makes it possible to use @Observable instead of ObservableObject.

### 💡 Changes

* `DeckShuffleAnimation` uses @Observable instead of ObservableObject. 
* `FavoriteContext` uses @Observable instead of ObservableObject. 
* `UserDefaultsFavoriteService` uses a new store prefix that changes the key.

### 🚨 Breaking Changes

* `main` is the new main branch, replacing `master`.
* `FavoriteService` has been renamed to `FavoriteStore`.
* `UserDefaultsFavoriteService` has been renamed to `UserDefaultsFavoriteStore`.



## 2.0

### 💡 Adjustments

* The package now uses Swift 6.1. 
* There is a new demo app that targets iOS 26.
* `FavoriteContext` can be created without service generic.
