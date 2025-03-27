#  Getting Started

This article explains how to get started with DeckKit.



## Creating a deck of items

DeckKit can be used with any item type that implements the `Identifiable` protocol, like this `Hobby` type:

```swift
struct Hobby: DeckItem {
    var name: String
    var text: String
    var id: String { name }
}

let deck: [Hobby] = [
    .init(name: "Music", text: "I love music!"), 
    .init(name: "Movies", text: "...and movies!"), 
    .init(name: "Coding", text: "...and coding!")
]
```

DeckKit defines several ``Swift/Array`` extensions, to let you modify decks, e.g. ``Swift/Array/moveFirstItemToBack()``, ``Swift/Array/moveLastItemToFront()``.



## Displaying a deck of items

You can render any list of items with in either of the view components that DeckKit provides, e.g. ``DeckView`` or ``DeckPageView``.

@TabNavigator {
    
    @Tab("DeckView") {
        ``DeckView`` renders items as a deck of cards, where the user can swipe away the top card in any direction to move it to the bottom of the deck. The deck view can also trigger optional actions for each swipe direction:

        ```swift
        struct MyView: View {

            var body: some View {
                DeckView(
                    $hobbies,
                    swipeLeftAction: { .. },
                    swipeRightAction: { .. }
                ) { item in
                    // Return a card view for the provided item
                }
                .padding()
            }
        }
        ```
    }
    
    @Tab("DeckPageView") {
        
        ``DeckPageView`` renders items as a horizontally scrolling list of pages:
        
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

You can use a ``Card`` view as content view, to easily support a front and back faced card with flip support, or use any custom card view.


## Favorites

DeckKit has functionality for handling the favorite state of any `Identifiable` type, using the observable ``FavoriteContext`` type:

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
