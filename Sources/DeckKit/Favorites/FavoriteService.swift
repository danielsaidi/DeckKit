//
//  FavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This service protocol can be implemented any types that can
 toggle the favorite state of ``Favoritable`` items.
 */
public protocol FavoriteService: AnyObject {
    
    /// Get all favorite item IDs.
    func getFavorites<Item: Identifiable>(for type: Item.Type) -> [Item.ID]
    
    /// Check whether or not a certain item is a favorite.
    func isFavorite<Item: Identifiable>(_ item: Item) -> Bool
    
    /// Set whether or not a certain item is a favorite.
    func setIsFavorite<Item: Identifiable>(_ isFavorite: Bool, for item: Item)
    
    /// Toggle whether or not a certain item is a favorite.
    func toggleIsFavorite<Item: Identifiable>(for item: Item)
}
