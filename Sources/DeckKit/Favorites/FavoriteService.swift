//
//  FavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented classes that can toggle
/// the favorite state of any `Identifiable` item type.
public protocol FavoriteService: AnyObject {

    /// The item type that is managed by this service.
    associatedtype Item: Identifiable

    /// Get all favorite item IDs.
    func getFavorites() -> [Item.ID]
    
    /// Check whether or not a certain item is a favorite.
    func isFavorite(_ item: Item) -> Bool
    
    /// Set whether or not a certain item is a favorite.
    func setIsFavorite(_ isFavorite: Bool, for item: Item)
    
    /// Toggle whether or not a certain item is a favorite.
    func toggleIsFavorite(for item: Item)
}
