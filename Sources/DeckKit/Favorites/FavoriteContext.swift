//
//  FavoriteContext.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This observable object context can be used to bind favorite
 state to your views.
 */
public class FavoriteContext<Item: Identifiable>: ObservableObject, FavoriteService {
    
    /**
     Create a favorite context.
     
     - Parameters:
       - service: The service to use to manage favorites, by default a ``UserDefaultsFavoriteService``.
     */
    public init(
        service: FavoriteService = UserDefaultsFavoriteService()
    ) {
        self.service = service
        self.favorites = getFavorites(for: Item.self)
    }
    
    private let service: FavoriteService
    
    
    /// The item IDs that are currently marked as favorites.
    @Published
    public private(set) var favorites: [Item.ID] = []
    
    /// Whether or not to only show favorites.
    @AppStorage("com.deckkit.favorites.showonlyfavorites")
    public var showOnlyFavorites = false
    
    
    /// Get the raw list of favorites from the embedded service.
    public func getFavorites<ItemType: Identifiable>(for type: ItemType.Type) -> [ItemType.ID] {
        service.getFavorites(for: ItemType.self)
    }
    
    /// Check whether or not a certain item is a favorite.
    public func isFavorite<ItemType: Identifiable>(_ item: ItemType) -> Bool {
        service.isFavorite(item)
    }
    
    /// Set whether or not a certain item is a favorite.
    public func setIsFavorite<ItemType: Identifiable>(_ isFavorite: Bool, for item: ItemType) {
        service.setIsFavorite(isFavorite, for: item)
        favorites = getFavorites(for: ItemType.self) as? [Item.ID] ?? []
    }
    
    /// Toggle whether or not a certain item is a favorite.
    public func toggleIsFavorite<ItemType: Identifiable>(for item: ItemType) {
        service.toggleIsFavorite(for: item)
        favorites = getFavorites(for: ItemType.self) as? [Item.ID] ?? []
    }
}
