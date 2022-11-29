import SwiftUI

#if os(iOS) || os(macOS)
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


@available(*, deprecated, message: "Use the itemDisplayCount initializer instead.")
extension StackedDeckConfiguration {

    /**
     Create a stacked deck configuration.

     - Parameters:
       - direction: The visual direction of the stack, by default `.up`.
       - cardDisplayCount: The max number of cards to display, by default `10`.
       - alwaysShowLastCard: Whether or not to show the last card for visual stability, by default `true`.
       - scaleOffset: The percentual factor to shrink cards for each step down the stack, by default `0.02`.
       - verticalOffset: The vertical offset to apply to cards for each step down the stack, by default `10`.
       - dragRotationFactor: The offset factor with which to rotate a card when it's panned, by default `0.05`.
       - horizontalDragThreshold: The number of points a card must be panned to be moved to the bottom of the deck, by default `100`.
       - verticalDragThreshold: The number of points a card must be panned to be moved to the bottom of the deck, by default `250`.
     */
    public init(
        direction: Direction = .up,
        cardDisplayCount: Int,
        alwaysShowLastCard: Bool = true,
        scaleOffset: Double = 0.02,
        verticalOffset: Double = 10,
        dragRotationFactor: Double = 0.01,
        horizontalDragThreshold: Double = 100,
        verticalDragThreshold: Double = 250
    ) {
        self.init(
            direction: direction,
            itemDisplayCount: cardDisplayCount,
            alwaysShowLastItem: alwaysShowLastCard,
            scaleOffset: scaleOffset,
            verticalOffset: verticalOffset,
            dragRotationFactor: dragRotationFactor,
            horizontalDragThreshold: horizontalDragThreshold,
            verticalDragThreshold: verticalDragThreshold
        )
    }
}
#endif
