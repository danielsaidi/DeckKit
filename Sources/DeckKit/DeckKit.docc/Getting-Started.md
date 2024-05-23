#  Getting Started

This article explains how to get started with DeckKit.



## How to create a deck of items

In DeckKit, a ``DeckItem`` is just a typealias for `Identifiable & Equatable`.

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
let music = Hobby(name: "Music", text: "I love music!"),
let movies = Hobby(name: "Movies", text: "...and movies!"),
let coding = Hobby(name: "Coding", text: "...and coding!")
let deck: [Hobby] = [music, movies, coding]
```

Once you have a collection of items, you can use any of the built-in functions to modify it, such as ``Swift/Array/moveFirstItemToBack()``, ``Swift/Array/moveLastItemToFront()``, etc.



## How to display a deck of items

You can render a ``DeckItem`` collection with in any of the built-in views, e.g. in a ``DeckView`` or a ``DeckPageView``:

@TabNavigator {
    
    @Tab("DeckView") {
        ``DeckView`` renders a ``DeckItem`` collection as a deck of cards, where the user can swipe the top card in any direction to move it to the bottom of the deck and trigger optional actions in each direction:

        ```swift
        struct MyView: View {

            var body: some View {
                DeckView($hobbies) { item in
                    // Return a card view for the provided item
                }
                .padding()
            }
        }
        ```

        You can use the ``SwiftUI/View/deckViewConfiguration(_:)`` view modifier to configure this view.
    }
    
    @Tab("DeckPageView") {
        
        ``DeckPageView`` renders a ``DeckItem`` collection as a horizontally scrolling page view:
        
        ```swift
        struct MyView: View {

            var body: some View {
                DeckPageView($hobbies) { item in
                    // Return a card view for the provided item
                }
                .padding()
            }
        }
        ```
    }
}


## 👑 How to manage favorites

DeckKit has functionality for handling the favorite state of any `Identifiable` type.

To track favorite state, you can just create a ``FavoriteContext`` instance as a :

```swift
struct MyView {

    @StateObject
    var context = FavoriteContext<Hobby>()
    
    body: some View {
        Button("Toggle favorite state") {
            context.toggleIsFavorite(for: coding)
        }
    }
}
``` 

The context uses a ``FavoriteService`` to manage favorites, and can be used to fetch all favorites, set and toggle favorite state, etc.


[Pro]: https://kankoda.com/deckkit
