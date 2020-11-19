# Release notes


## 0.2.0

The `deck` init params for `StackedDeck` and `HorizontalDeck` has been changed to a binding.

This gives you better control over the deck, removes UI glitches and helped me remove a bunch of state for visible cards in `StackDeck`, which means that deck modifications now instantly trigger UI changes. 

I have added a shuffle button to the demo to demonstrate how much better the stacked deck performs.

The `StackedDeck` has been improved in more ways:

* I have changed the order of how the vertical offset and scale effect are applied, which fixes a UI glitch.
* I have added `swipeLeft/Right/Up/Down` actions which let you trigger actions depending on how a user swipes a card of the top of the deck.

The `DeckContext` class is still in the library, but is not used by the library itself.


## 0.1.1

This version was just made to force the CocoaPod to pass validation. 


## 0.1.0

This version is the first public release of DeckKit. 

It contains components that are used in apps that have been pushed to production, which is why I decided to release it as a first minor.
