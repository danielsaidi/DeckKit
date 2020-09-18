//
//  Deck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct can be used to create a deck of items, that can
 then be converted to views when the deck is presented.
 */
public struct Deck<Item: CardItem>: Identifiable, Equatable {
    
    public init(
        name: String,
        items: [Item]) {
        self.name = name
        self.items = items
    }
    
    public let id = UUID()
    public let name: String
    public var items: [Item]
}

public extension Deck {
    
    func index(of card: Item) -> Int {
        items.firstIndex { $0.id == card.id } ?? 0
    }
    
    mutating func moveToBack(_ card: Item) {
        let topCard = items.remove(at: index(of: card))
        items.append(topCard)
    }
    
    mutating func moveToFront(_ card: Item) {
        guard items.count > 0 else { return }
        if items[0].id == card.id { return }
        let topCard = items.remove(at: index(of: card))
        items.insert(topCard, at: 0)
    }
}
