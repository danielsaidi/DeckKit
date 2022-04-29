#  Getting Started

This article describes how you get started with DeckKit.


## Installation

DeckKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/BottomSheet.git
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







The library's main view is ``BottomSheet``, which can be created with an `isExpanded` binding, a `minHeight` and `maxHeight` and a `style`.

```swift
import SwiftUI
import BottomSheet

struct MyView {

    @State private var isSheetExpanded = false

    let sheet = BottomSheet(
        isExpanded: $isSheetExpanded,
        minHeight: .points(100),
        maxHeight: .available,
        style: .standard
    )

    var body: some View {
        List(items) { item
           HStack { item.name }
        }.bottomSheet(sheet)
    }
}
```

Once you have a sheet, you can add it to any view, using the `bottomSheet` as can be seen above.

The sheet will be added above the view and docked to the bottom. It can then be swiped up and down or expanded and collapsed by tapping the handle.


## Heights

A ``BottomSheet`` is created with a ``BottomSheetHeight`` `minHeight` and `maxHeight`, which is an enum with these cases:

* `available` - the total available height
* `percentage` - a percentage of the total available height
* `points` - a fixed number of points

You can set these to control how tall your sheet can become and how much it can collapse. You can change these properties at any time.


## Styling

A ``BottomSheet`` is created with a ``BottomSheetStyle`` `style`, which is an enum with these properties:

* `color` - the color of the sheet
* `cornerRadius` - the corner radius of the sheet
* `modifier` - the modifier to apply to the sheet
* `snapRatio` - the percent of the max height, after which the sheet slides to the full height
* `handleStyle` - the bottom sheet's handle style

You can define your own styles and apply them when creating a bottom sheet.


## Important

This library uses resource-based colors, which aren't available to SwiftUI previews outside of this library.

Make sure to always use the `.preview` style when previewing a sheet.    


## Conclusion

That's about it. Enjoy using this custom bottom sheet in SwiftUI!
