//
//  Deck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
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
       - id: The unique id of the deck.
       - name: The name of the deck.
       - items: The items to include in the deck.
     */
    public init(
        id: UUID = UUID(),
        name: String,
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
     The index of a certain card item, if any.
     */
    func index(of card: Item) -> Int? {
        items.firstIndex { $0.id == card.id }
    }
    
    /**
     Move a card to the back of the deck.
     */
    mutating func moveToBack(_ card: Item) {
        guard let index = index(of: card) else { return }
        let topCard = items.remove(at: index)
        items.append(topCard)
    }
    
    /**
     Move a card to the front of the deck.
     */
    mutating func moveToFront(_ card: Item) {
        guard let index = index(of: card) else { return }
        if items[0].id == card.id { return }
        let topCard = items.remove(at: index)
        items.insert(topCard, at: 0)
    }
}
