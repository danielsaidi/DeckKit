#  Getting Started

This article explains how to get started with DeckKit.



## How to create a deck of items

In DeckKit, the data source of a deck view is just an array of ``DeckItem`` values.

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
var deck: [Hobby] = [
    .init(name: "Music", text: "I love music!"),
    .init(name: "Movies", text: "...and movies!"),
    .init(name: "Programming", text: "...but most of all programming!")
]
```

Once you have a collection of items, you can use any of the built-in functions to modify it, such as `moveFirstItemToBack()`, `moveLastItemToFront()`, `shuffle()`, etc.



## How to display a deck of items

You can display a collection of ``DeckItem``s with in any of the built-in views.


### DeckView

The ``DeckView`` component lists all items in a collection in a stack:

```swift
struct MyView: View {

    @State var items: [Hobby] = [
        .init(name: "Music", text: "I love music!"),
        .init(name: "Movies", text: "...and movies!"),
        .init(name: "Programming", text: "...but most of all programming!")
    ]

    var body: some View {
        DeckView($items) { item in
            ... Return your view here
        }
        .padding()
    }
}
```

You can style and configure the deck view to great extent. Users can swipe the topmost card to any edge to send it to the back, trigger custom actions for each edge, etc.


### 👑 DeckPageView

The **DeckPageView** component in [DeckKit Pro][Pro] lists deck items in a horizontally paged list:

```swift
DeckPageView($items) { item in
    ... Return your view here
}
```

A page view is a great way to swipe back and forth through a collection of items.


### 👑 DeckFanView

The **DeckFanView** component in [DeckKit Pro][Pro] lists deck items in a fan layout:

```swift
DeckFanView($items) { item in
    ... Return your view here
}
```

You can rotate the fan, select any item in the collection, etc. 



## 👑 How to manage favorites

[DeckKit Pro][Pro] has functionality for handling favorites.

To track favorite state, you can just create a ``FavoriteContext`` instance:

```swift
@StateObject
var context = FavoriteContext()
``` 

The context can be injected as an environment object, passed around as a reference, etc. It uses an injected ``FavoriteService`` to manage favorites, and can be used to fetch all favorites, toggle favorite state of an item, etc.


[Pro]: https://kankoda.com/deckkit
