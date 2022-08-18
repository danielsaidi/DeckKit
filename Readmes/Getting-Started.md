#  Getting Started

This article describes how you get started with DeckKit.


## Installation

DeckKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/DeckKit.git
``` 

or with CocoaPods:

```
pod DeckKit
```


## Creating a deck

In DeckKit, a ``Deck`` is the model that can be bound to various views.

You create a deck by giving it an optional name and a set of items that implement the ``DeckItem`` protocol.

For instance, consider a list of hobbies, where the `Hobby` struct looks like this:

```swift
struct Hobby: CardItem {
    
    let id = UUID().uuidString
    
    var name: String
    var text: String
    var imageName: String
    var color: Color
    
    var backgroundColor: Color { color }
    var foregroundColor: Color {
        switch backgroundColor {
        case .white: return .black
        default: return .white
        }
    }
    var image: Image { Image(systemName: imageName) }
}
```

You can now create a deck like this:

```swift
let deck = Deck(
    name: "Hobbies",
    items: [hobby1, hobby2, hobby3]
)
```

We can now display this deck in any of the build-in views.



## Managing state

When displaying a deck in SwiftUI, you can manage state in different ways.

The easiest way is to specify the deck as `@State`:

```swift
struct MyView: View {

    @State
    private var deck = Deck(name: "Hobbies", items: ...)
    
    var body: some View {
        ...
    }
}
```

If you need a reference type, you can create a ``DeckContext`` and pass it around in your app:

```swift
struct MyView: View {

    @StateObject
    private var deckContext = DeckContext(
        deck: Deck(name: "Hobbies", items: ...))
    
    var body: some View {
        ...
    }
}
```
 
The context can be passed around, be injected as an environment object etc.



## Displaying a deck of cards

Once you have your deck with items, you can display your items as cards in a deck.

To display items as a stack of cards, where the cards are stacked on top ov each other, you can use ``StackedDeck``:

```swift
StackedDeck(deck: myDeck) { item in
    MyCardView(item: item)
}
```

You can customize this stack to great extent and control how many cards that are displayed, how they are displayed and what to do when a card is swiped in various directions.

To display items in a horizontal list, you can use the ``HorizontalDeck`` instead:

```swift
HorizontalDeck(deck: myDeck) { item in
    MyCardView(item: item)
}
```

This view just lists the generated views in a lazy horizontal stack that is wrapped in a horizontal scroll view.



## Favorites

DeckKit also has functionality for handling favorites, since this is a common use-case.

To track favorite state, you can just create a ``FavoriteContext`` instance:

```swift
@StateObject
var context = FavoriteContext()
``` 

This context can be injected as an environment object, passed around as a reference etc.

The context uses an injected ``FavoriteService`` to manage favorites. It uses a ``UserDefaultsFavoriteService`` by default, but you can provide it with any custom implementation.

You can then use the context to fetch all favorites of a certain type, toggle their favorite state etc. You can use any types that implement the ``Favoritable`` protocol.



## Conclusion

That's about it. Enjoy using this library to create deck-based apps in SwiftUI!
