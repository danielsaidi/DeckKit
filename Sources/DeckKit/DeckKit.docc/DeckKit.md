# ``DeckKit``

DeckKit is a Swift SDK that helps you build deck-based apps in SwiftUI.



## Overview

![DeckKit logo](Logo.png)

DeckKit is a Swift SDK that helps you build deck-based apps in SwiftUI.

DeckKit has a ``DeckItem`` protocol that is automatically implemented by any type that implements `Identifiable` and `Equatable`, and extends any such ``Swift/Array`` with more functionality.

DeckKit has a ``DeckView`` that can render an item collection as a physical deck of cards, as well as a ``DeckPageView`` that renders an item collection as a horizontally scrolling page view.

DeckKit can be customized to great extent. You can change colors, fonts, corner radius etc., and use completely custom views. You can also use a ``FavoriteContext`` to manage the favorite state of any `Identifiable` type.



## Installation

DeckKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/DeckKit.git
```



## Getting started

The <doc:Getting-Started> article helps you get started with DeckKit.



## Repository

For more information, source code, etc., visit the [project repository](https://github.com/danielsaidi/DeckKit).



## License

DeckKit is available under the MIT license.



## Topics

### Articles

- <doc:Getting-Started>

### Decks

- ``DeckItem``
- ``DeckPageView``
- ``DeckView``
- ``DeckViewConfiguration``

### Animations

- ``DeckShuffleAnimation``

### Favorites

- ``FavoriteContext``
- ``FavoriteService``
- ``UserDefaultsFavoriteService``
