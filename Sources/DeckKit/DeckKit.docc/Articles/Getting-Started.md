#  Getting Started

This article describes how you get started with DeckKit.


## Creating a deck

In DeckKit, a ``Deck`` can be used to define a deck of ``DeckItem`` values.

For instance, consider this `Hobby` type:

```swift
struct Hobby: DeckItem {
    
    var name: String
    var text: String

    var id: String { name }
}
```

You can easily define a deck of hobbies like this:

```swift
extension Deck {
    
    static var hobbies: Deck<Hobby> {
        .init(
            name: "Hobbies",
            items: [
                Hobby(name: "Music", text: "I love music!"),
                Hobby(name: "Movies", text: "I also love movies!"),
                Hobby(name: "Programming", text: "Not to mention programming!")
            ]
        )
    }
}
```

and display your deck in some of the built-in views, like a ``DeckView``:

```swift
struct MyView: View {

    @State var deck = Deck<Hobby>.hobbies

    var body: some View {
        DeckView(deck: $deck) { hobby in
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(.blue)
                .overlay(Text(hobby.name))
                .shadow(radius: 10)
        }
        .padding()
    }
}
```

You can easily customize these deck views with convenient view modifiers:

```swift
struct MyView: View {

    @State var deck = Deck<Hobby>.hobbies

    var body: some View {
        DeckView(deck: $deck) { hobby in
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(.blue)
                .overlay(Text(hobby.name))
                .shadow(radius: 10)
        }
        .padding()
        .deckViewConfiguration(
            .init(direction: .down)
        )
    }
}
```

You can use configurations to control the visual direction, the number of visible items, drag threshold, etc.

Views have different capabilities. For instance, a ``DeckView`` can trigger custom actions when a card is dragged to specific edges. 



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

That's about it. I hope you enjoy using this library to create deck-based apps in SwiftUI!
