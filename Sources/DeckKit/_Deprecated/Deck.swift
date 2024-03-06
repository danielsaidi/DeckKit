//
//  Deck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "Deck is no longer needed. Just use item arrays instead.")
public struct Deck<Item: DeckItem>: Identifiable, Equatable {
    
    /**
     Create a deck with items.
     
     - Parameters:
       - id: The unique id of the deck, by default `UUID()`.
       - name: The name of the deck, by default `.empty`.
       - items: The items to include in the deck.
     */
    public init(
        id: UUID = UUID(),
        name: String = "",
        items: [Item]
    ) {
        self.id = id
        self.name = name
        self.items = items
    }
    
    /// The unique id of the deck.
    public let id: UUID
    
    /// The name of the deck.
    public let name: String
    
    /// The items that are added to the deck.
    public var items: [Item]
}

public extension DeckView {
    
    @available(*, deprecated, message: "Deck is no longer needed. Just use item arrays instead.")
    init(
        deck: Binding<Deck<ItemType>>,
        config: DeckViewConfiguration = .standard,
        shuffleAnimation: DeckShuffleAnimation = .init(),
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        itemView: @escaping ItemViewBuilder
    ) {
        self.init(
            deck.items,
            config: config,
            shuffleAnimation: shuffleAnimation,
            swipeLeftAction: swipeLeftAction,
            swipeRightAction: swipeRightAction,
            swipeUpAction: swipeUpAction,
            swipeDownAction: swipeDownAction,
            itemView: itemView
        )
    }
}

#if os(iOS)
public extension DeckPageView {
    
    @available(*, deprecated, message: "Deck is no longer needed. Just use item arrays instead.")
    init(
        _ deck: Binding<Deck<ItemType>>,
        itemView: @escaping ItemViewBuilder
    ) {
        self.init(deck.items, itemView: itemView)
    }
}
#endif

public extension DeckShuffleAnimation {
    
    @available(*, deprecated, message: "Deck is no longer needed. Just use item arrays instead.")
    func shuffle<Item>(
        _ deck: Binding<Deck<Item>>,
        times: Int = 3
    ) {
        shuffle(deck.items, times: times)
    }
}

public extension View {

    @available(*, deprecated, message: "Deck is no longer needed. Just use item arrays instead.")
    func withShuffleAnimation<Item: DeckItem>(
        _ animation: DeckShuffleAnimation,
        for item: Item,
        in deck: Deck<Item>
    ) -> some View {
        self.withShuffleAnimation(animation, for: item, in: deck.items)
    }
}

@available(*, deprecated, message: "Deck is no longer needed. Just use item arrays instead.")
public extension Deck {
    
    /// The index of a certain item, if any.
    func index(of item: Item) -> Int? {
        items.firstIndex { $0.id == item.id }
    }
    
    /// Move the first item to the back of the deck.
    mutating func moveFirstItemToBack() {
        guard let item = items.first else { return }
        moveToBack(item)
    }
    
    /// Move the last item to the front of the deck.
    mutating func moveLastItemToFront() {
        guard let item = items.last else { return }
        moveToFront(item)
    }
    
    /// Move an item to the back of the deck.
    mutating func moveToBack(_ item: Item) {
        guard let index = index(of: item) else { return }
        let topItem = items.remove(at: index)
        items.append(topItem)
    }

    /// Move an item to the front of the deck.
    mutating func moveToFront(_ item: Item) {
        guard let index = index(of: item) else { return }
        if items[0].id == item.id { return }
        let topItem = items.remove(at: index)
        items.insert(topItem, at: 0)
    }

    /// Shuffle the deck.
    mutating func shuffle() {
        items.shuffle()
    }
}
