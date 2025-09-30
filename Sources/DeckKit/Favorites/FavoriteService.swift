//
//  FavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can manage favorites.
public protocol FavoriteService: AnyObject {

    /// The item type that is managed by this service.
    associatedtype Item: Identifiable

    /// Get all favorites.
    func getFavorites() -> [Item.ID]
    
    /// Check if a certain item is marked as a favorite.
    func isFavorite(_ item: Item) -> Bool
    
    /// Set the favorite state of a certain item.
    func setIsFavorite(_ isFavorite: Bool, for item: Item)
    
    /// Toggle the favorite state of a certain item.
    func toggleIsFavorite(for item: Item)
}
