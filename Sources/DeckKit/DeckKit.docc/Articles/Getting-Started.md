#  Getting Started

This article describes how you get started with DeckKit.


## Creating a deck

In DeckKit, a ``Deck`` is used to define a deck of items. You create a deck by giving it an optional ID and name as well as a set of items that implement the ``DeckItem`` protocol.

For instance, consider a hobby type that looks like this:

```swift
struct Hobby: DeckItem {
    
    var name: String
    var text: String

    var id: String { name }
}
```

You can now create a deck with hobbies and display it in a ``DeckView``:

```swift
struct MyView: View {

    @State
    var deck = Deck(
        name: "Hobbies",
        items: [
            Hobby(name: "Music", text: "I love music!"), 
            Hobby(name: "Movies", text: "I also love movies!!"), 
            Hobby(name: "Programming", text: "Not to mention programming!!!")
        ]
    )

    var body: some View {
        DeckView(
            deck: $deck,
            config: .init(direction: .down),
            itemViewBuilder: { hobby in
                // Create a view for the hobby here
            }
        ).padding()
    }
}
```



## Managing state

When displaying a deck in SwiftUI, you can manage state in different ways.

The easiest way is to specify the deck as state:

```swift
struct MyView: View {

    @State
    private var deck = Deck(
        name: "Hobbies", 
        items: ...
    )
    
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
        deck: Deck(
            name: "Hobbies", 
            items: ...
        )
    )
    
    var body: some View {
        ...
    }
}
```
 
A context can be passed around, injected as an environment object etc.



## Configuring the deck view

The ``DeckView`` takes a ``DeckViewConfiguration`` parameter that can be used to configure the view in various ways. You can for instance use it to control the visual direction, the number of visible items, the drag threshold before sending an item to the back of the stack etc.



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
