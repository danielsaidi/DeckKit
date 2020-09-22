//
//  StackedDeck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view presents a deck as a horizontal list.
 
 This view takes a generic `Deck` as init parameter, as well
 as and a `cardBuilder` that takes the same card type as the
 deck as input parameter and returns a view.
 */
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct HorizontalDeck<ItemType: CardItem>: View {
    
    /// Creates an instance of the view.
    ///
    /// - Parameters:
    ///   - deck: The generic deck that is to be presented.
    ///   - cardBuilder: A builder that generates card views.
    public init(
        deck: Deck<ItemType>,
        cardBuilder: @escaping CardBuilder) {
        self.context = DeckContext(deck: deck)
        self.cardBuilder = cardBuilder
    }
    
    /**
     A function that takes an item and returns a card view.
     */
    public typealias CardBuilder = (ItemType) -> AnyView
    
    private let cardBuilder: (ItemType) -> AnyView
    private var deck: Deck<ItemType> { context.deck }
    private var items: [ItemType] { deck.items }
    
    @ObservedObject private var context: DeckContext<ItemType>
    
    public var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(items) {
                    cardBuilder($0)
                }
            }
        }
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct HorizontalDeck_Previews: PreviewProvider {
    
    static var item1: BasicItem { BasicItem(
        title: "Title 1",
        text: "Text 1",
        footnote: "Footnote 1",
        backgroundColor: .red,
        tintColor: .yellow)
    }
    
    static var item2: BasicItem { BasicItem(
        title: "Title 2",
        text: "Text 2",
        footnote: "Footnote 2",
        backgroundColor: .yellow,
        tintColor: .red)
    }
    
    static var deck = Deck(
        name: "My Deck",
        items: [item1, item2, item1, item2, item1, item2, item1, item2, item1, item2, item1, item2])
    
    static var previews: some View {
        HorizontalDeck(
            deck: deck,
            cardBuilder: { AnyView(BasicCard(item: $0)) })
            .background(Color.secondary)
    }
}
