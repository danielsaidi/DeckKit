# Release notes


## 0.2.0

This version changes the `deck` init params for `StackedDeck` and `HorizontalDeck` to a binding, to avoid having the deck reset everytime the view hierarchy reloads.

With this change, I could remove state for visible cards in `StackDeck`, to make deck modifications instantly trigger UI changes. I have added a shuffle button to the demo to demonstrate this.

The `DeckContext` class is still in the library, but is not used by the library itself.


## 0.1.1

This version was just made to force the CocoaPod to pass validation. 


## 0.1.0

This version is the first public release of DeckKit. 

It contains components that are used in apps that have been pushed to production, which is why I decided to release it as a first minor.
