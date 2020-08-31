//
//  DeckContext.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This context class can be used to help observing deck state
 in SwiftUI views.
 */
public class DeckContext<CardType: Card>: ObservableObject {
    
    public init(deck: Deck<CardType>) {
        self.deck = deck
    }
    
    @Published public var deck: Deck<CardType>
}
