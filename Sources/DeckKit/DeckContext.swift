//
//  DeckContext.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This context can be used to observe deck state in SwiftUI.
 */
public class DeckContext<CardType: DeckItem>: ObservableObject {
    
    /**
     Create a deck context.
     
     - Parameters:
       - deck: The deck to track with the context.
     */
    public init(deck: Deck<CardType>) {
        self.deck = deck
    }
    
    @Published
    public var deck: Deck<CardType>
}
