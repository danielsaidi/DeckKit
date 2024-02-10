import SwiftUI

public extension DeckView {
    
    @available(*, deprecated, message: "Use the .deckViewConfiguration view modifier to specify a custom configuration.")
    init(
        deck: Binding<Deck<ItemType>>,
        config: DeckViewConfiguration,
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        itemView: @escaping ItemViewBuilder
    ) {
        self.init(
            deck: deck,
            swipeLeftAction: swipeLeftAction,
            swipeRightAction: swipeRightAction,
            swipeUpAction: swipeUpAction,
            swipeDownAction: swipeDownAction,
            itemView: itemView
        )
        self.legacyConfig = config
    }
}
