//
//  Deck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

public struct Deck<CardType: Card>: Identifiable, Equatable {
    
    public init(
        name: String,
        cards: [CardType]) {
        self.name = name
        self.cards = cards
    }
    
    public let id = UUID()
    public let name: String
    public var cards: [CardType]
}

public extension Deck {
    
    func index(of card: CardType) -> Int {
        cards.firstIndex { $0.id == card.id } ?? 0
    }
    
    mutating func moveToBack(_ card: CardType) {
        let topCard = cards.remove(at: index(of: card))
        cards.append(topCard)
    }
    
    mutating func moveToFront(_ card: CardType) {
        let topCard = cards.remove(at: index(of: card))
        cards.insert(topCard, at: 0)
    }
}
