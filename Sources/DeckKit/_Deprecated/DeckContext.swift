//
//  DeckContext.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Deck is no longer needed. You can just use arrays instead.")
public class DeckContext<ItemType: DeckItem>: ObservableObject {
    
    /**
     Create a deck context.
     
     - Parameters:
       - deck: The deck to track with the context.
     */
    public init(deck: Deck<ItemType>) {
        self.deck = deck
    }
    
    @Published
    public var deck: Deck<ItemType>
}
