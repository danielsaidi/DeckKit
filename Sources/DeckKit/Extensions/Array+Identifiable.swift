//
//  Array+Identifiable.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Array where Element: Identifiable {
    
    /// Whether the collection contains certain item.
    func contains(_ item: Element) -> Bool {
        index(of: item) != nil
    }
    
    /// The index of a certain item, if any.
    func index(of item: Element) -> Int? {
        firstIndex { $0.id == item.id }
    }
    
    /// Move the first item to the back of the deck.
    mutating func moveFirstItemToBack() {
        guard let item = first else { return }
        moveToBack(item)
    }
    
    /// Move the last item to the front of the deck.
    mutating func moveLastItemToFront() {
        guard let item = last else { return }
        moveToFront(item)
    }
    
    /// Move an item to the back of the deck.
    mutating func moveToBack(_ item: Element) {
        guard let index = index(of: item) else { return }
        let topItem = remove(at: index)
        append(topItem)
    }

    /// Move an item to the front of the deck.
    mutating func moveToFront(_ item: Element) {
        guard let index = index(of: item) else { return }
        if self[0].id == item.id { return }
        let topItem = remove(at: index)
        insert(topItem, at: 0)
    }
}
