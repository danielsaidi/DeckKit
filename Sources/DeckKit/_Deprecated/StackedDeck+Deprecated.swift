import SwiftUI

@available(*, deprecated, renamed: "DeckView")
public typealias StackedDeck = DeckView

@available(*, deprecated, renamed: "DeckViewConfiguration")
public typealias StackedDeckConfiguration = DeckViewConfiguration

@available(*, deprecated, message: "Use the itemViewBuilder initializer instead.")
extension StackedDeck {

    /**
     Creates an instance of the view.

     - Parameters:
       - deck: The generic deck that is to be presented.
       - config: The stacked deck configuration, by default ``DeckViewConfiguration/standard``.
       - swipeLeftAction: The action to trigger when a card is sent to the back of the deck by swiping it left, by default `nil`.
       - swipeRightAction: The action to trigger when a card is sent to the back of the deck by swiping it right, by default `nil`.
       - swipeUpAction: The action to trigger when a card is sent to the back of the deck by swiping it up, by default `nil`.
       - swipeDownAction: The action to trigger when a card is sent to the back of the deck by swiping it down, by default `nil`.
       - cardBuilder: A builder that generates a card view for each item in the deck.
     */
    public init(
        deck: Binding<Deck<ItemType>>,
        config: DeckViewConfiguration,
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        cardBuilder: @escaping ItemViewBuilder
    ) {
        self.init(
            deck: deck,
            config: config,
            swipeLeftAction: swipeLeftAction,
            swipeRightAction: swipeRightAction,
            swipeUpAction: swipeUpAction,
            swipeDownAction: swipeDownAction,
            itemViewBuilder: cardBuilder
        )
    }
}
