//
//  DeckPageView.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-12-31.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/**
 This view renders a ``Deck`` as a horizontal page view from
 which users can swipe left and right.

 The view takes a generic ``Deck`` and maps its items to any
 views, as determined by the `itemViewBuilder`.
 */
public struct DeckPageView<ItemType: DeckItem, ItemView: View>: View {

    /**
     Create a deck view with a standard view configuration.

     - Parameters:
       - deck: The deck to present.
       - itemView: An item view builder to use for each item in the deck.
     */
    public init(
        _ deck: Binding<Deck<ItemType>>,
        itemView: @escaping ItemViewBuilder
    ) {
        self.deck = deck
        self.itemView = itemView
    }
    
    /// A function that creates a view for a deck item.
    public typealias ItemViewBuilder = (ItemType) -> ItemView
    
    private var deck: Binding<Deck<ItemType>>
    private let itemView: (ItemType) -> ItemView

    public var body: some View {
        TabView {
            ForEach(items) {
                itemView($0)
            }
        }
        .tabViewStyle(.page)
    }
}


// MARK: - Properties

private extension DeckPageView {

    var items: [ItemType] {
        deck.wrappedValue.items
    }
}


// MARK: - Preview

#Preview {
    
    var item1: PreviewCard.Item { PreviewCard.Item(
        title: "Title 1",
        text: "Text 1",
        footnote: "Footnote 1",
        backgroundColor: .blue,
        tintColor: .yellow)
    }

    var item2: PreviewCard.Item { PreviewCard.Item(
        title: "Title 2",
        text: "Text 2",
        footnote: "Footnote 2",
        backgroundColor: .yellow,
        tintColor: .blue)
    }

    @State
    var deck = Deck(
        name: "My Deck",
        items: [
            item1, item2, item1, item2, item1, item2,
            item1, item2, item1, item2, item1, item2,
            item1, item2, item1, item2, item1, item2,
            item1, item2, item1, item2, item1, item2
        ]
    )

    return DeckPageView($deck) {
        PreviewCard(item: $0)
            .padding(15)
            .frame(maxHeight: 350)
    }.background(Color.gray)
}
#endif
