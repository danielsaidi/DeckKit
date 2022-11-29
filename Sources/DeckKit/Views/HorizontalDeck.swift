//
//  StackedDeck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view presents a deck of cards as a horizontal list.
 
 This view takes a generic `Deck` as init parameter, as well
 as and a `cardBuilder` that takes the same card type as the
 deck as input parameter and returns a view.
 */
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct HorizontalDeck<ItemType: DeckItem, ItemView: View>: View {

    /**
     Create a horizontal deck.

     - Parameters:
       - deck: The generic deck that is to be presented.
       - spacing: The spacing to put between items, by default `20`.
       - cardBuilder: A builder that generates card views.
     */
    public init(
        deck: Binding<Deck<ItemType>>,
        spacing: Double = 20,
        cardBuilder: @escaping CardBuilder
    ) {
        self.deck = deck
        self.spacing = spacing
        self.cardBuilder = cardBuilder
    }

    /**
     A function that builds a view for a deck item.
     */
    public typealias CardBuilder = (ItemType) -> ItemView
    
    private let cardBuilder: CardBuilder
    private let deck: Binding<Deck<ItemType>>
    private let spacing: Double
    private var items: [ItemType] { deck.wrappedValue.items }
    
    public var body: some View {
        LazyHStack(spacing: spacing) {
            ForEach(items) {
                cardBuilder($0)
            }
        }
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct HorizontalDeck_Previews: PreviewProvider {
    
    static var item1: BasicCard.Item { BasicCard.Item(
        title: "Title 1",
        text: "Text 1",
        footnote: "Footnote 1",
        backgroundColor: .red,
        tintColor: .yellow)
    }
    
    static var item2: BasicCard.Item { BasicCard.Item(
        title: "Title 2",
        text: "Text 2",
        footnote: "Footnote 2",
        backgroundColor: .yellow,
        tintColor: .red)
    }

    static func card(
        for item: BasicCard.Item,
        geo: GeometryProxy
    ) -> some View {
        BasicCard(item: item)
            .aspectRatio(geo.size.width / geo.size.height, contentMode: .fit)
            .frame(maxWidth: geo.size.width - 30)
    }
    
    static var deck = Deck(
        name: "My Deck",
        items: [item1, item2, item1, item2, item1, item2, item1, item2, item1, item2, item1, item2])
    
    static var previews: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                HorizontalDeck(
                    deck: .constant(deck),
                    spacing: 20,
                    cardBuilder: { item in card(for: item, geo: geo) }
                ).padding(.horizontal)
            }.background(Color.secondary.edgesIgnoringSafeArea(.all))
        }
    }
}
