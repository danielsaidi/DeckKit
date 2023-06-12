//
//  Deck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct represents a deck with an id, a name as well as
 a collection of ``DeckItem`` items.
 */
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
        items: [Item]) {
        self.id = id
        self.name = name
        self.items = items
    }
    
    /**
     The unique id of the deck.
     */
    public let id: UUID
    
    /**
     The name of the deck.
     */
    public let name: String
    
    /**
     The items that are added to the deck.
     */
    public var items: [Item]
}

public extension Deck {
    
    /**
     The index of a certain item, if any.
     */
    func index(of item: Item) -> Int? {
        items.firstIndex { $0.id == item.id }
    }
    
    /**
     Move an item to the back of the deck.
     */
    mutating func moveToBack(_ item: Item) {
        guard let index = index(of: item) else { return }
        let topItem = items.remove(at: index)
        items.append(topItem)
    }

    /**
     Move an item to the front of the deck.
     */
    mutating func moveToFront(_ item: Item) {
        guard let index = index(of: item) else { return }
        if items[0].id == item.id { return }
        let topItem = items.remove(at: index)
        items.insert(topItem, at: 0)
    }

    /**
     Shuffle the deck.
     */
    mutating func shuffle() {
        items.shuffle()
    }
}
