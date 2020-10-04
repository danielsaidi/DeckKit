# Release notes


## 0.2.0

The `deck` init params for `StackedDeck` and `HorizontalDeck` has been changed to a binding. This helps avoiding that the deck UI resets everytime the view hierarchy reloads.

With this change, I could also remove a bunch of state for visible cards in `StackDeck`, which makes deck modifications instantly trigger UI changes. I have added a shuffle button to the demo to demonstrate this.

I have changed the order of the `StackDeck`'s vertical card offset and scale effect, to fix a UI glitch. 

The `DeckContext` class is still in the library, but is not used by the library itself.


## 0.1.1

This version was just made to force the CocoaPod to pass validation. 


## 0.1.0

This version is the first public release of DeckKit. 

It contains components that are used in apps that have been pushed to production, which is why I decided to release it as a first minor.
