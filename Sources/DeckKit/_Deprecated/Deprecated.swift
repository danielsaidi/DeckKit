import SwiftUI

@available(*, deprecated, message: "Just use Identifiable instead.")
public protocol DeckItem: Identifiable {}

@available(*, deprecated, renamed: "CardView")
public typealias Card = CardView

public extension CardView {
    
    @available(*, deprecated, message: "This view no longer applies a corner radius. Add this to the front and back views instead.")
    init(
        isFlipped: Bool,
        cornerRadius: Double,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back
    ) {
        self.init(isFlipped: isFlipped, front: front, back: back)
    }
}

@available(*, deprecated, message: "This is no longer used.")
public extension Color {

    /// A standard card background color, which is white for
    /// apps in light mode, and black in dark mode.
    static func card(
        for colorScheme: ColorScheme
    ) -> Self {
        colorScheme == .light ? .white : .black
    }
}

public extension DeckView {
    
    @available(*, deprecated, message: "This is no longer used.")
    typealias ItemAction = (ItemType) -> Void
    
    @available(*, deprecated, message: "Use the swipeAction initializer instead.")
    init(
        _ items: Binding<[ItemType]>,
        shuffleAnimation: DeckShuffleAnimation = .init(),
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        itemView: @escaping ItemViewBuilder
    ) {
        self.init(
            items,
            shuffleAnimation: shuffleAnimation,
            swipeAction: { edge, item in
                switch edge {
                case .leading: swipeLeftAction?(item)
                case .trailing: swipeRightAction?(item)
                case .top: swipeUpAction?(item)
                case .bottom: swipeDownAction?(item)
                }
            },
            itemView: itemView
        )
    }
    
    @available(*, deprecated, message: "Apply a configuration with the .deckViewConfiguration view modifier instead.")
    init(
        _ items: Binding<[ItemType]>,
        config: DeckViewConfiguration,
        shuffleAnimation: DeckShuffleAnimation = .init(),
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        itemView: @escaping ItemViewBuilder
    ) {
        self.init(
            items,
            shuffleAnimation: shuffleAnimation,
            swipeLeftAction: swipeLeftAction,
            swipeRightAction: swipeRightAction,
            swipeUpAction: swipeUpAction,
            swipeDownAction: swipeDownAction,
            itemView: itemView
        )
        self.initConfig = config
    }
}
