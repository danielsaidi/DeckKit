//
//  FavoriteContext.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This class can be used to manage the favorite state of any `Identifiable`.
///
/// The class uses a ``UserDefaultsFavoriteService`` to store state by
/// default, but you can use any custom service.
public class FavoriteContext<Item: Identifiable, Service: FavoriteService>: ObservableObject, FavoriteService where Service.Item == Item {

    /// Create a default context instance.
    ///
    /// This instance uses a ``UserDefaultsFavoriteService``.
    public init() where Service == UserDefaultsFavoriteService<Item> {
        self.service = UserDefaultsFavoriteService<Item>()
        self.favorites = getFavorites()
    }

    /// Create a context with a custom service.
    ///
    /// - Parameters:
    ///   - service: The service to use to manage favorites.
    public init(service: Service) where Item == Service.Item {
        self.service = service
        self.favorites = getFavorites()
    }

    private let service: Service

    /// The item IDs that are currently marked as favorites.
    @Published
    public private(set) var favorites: [Item.ID] = []

    /// Whether or not to only show favorites.
    @AppStorage("com.deckkit.favorites.showonlyfavorites")
    public var showOnlyFavorites = false
}

public extension FavoriteContext {

    /// Check if there are any favorites.
    var hasFavorites: Bool {
        !favorites.isEmpty
    }

    /// Get all favorites.
    func getFavorites() -> [Item.ID] {
        service.getFavorites()
    }
    
    /// Check if a certain item is marked as a favorite.
    func isFavorite(_ item: Item) -> Bool {
        service.isFavorite(item)
    }
    
    /// Set the favorite state of a certain item.
    func setIsFavorite(_ isFavorite: Bool, for item: Item) {
        service.setIsFavorite(isFavorite, for: item)
        favorites = getFavorites()
    }
    
    /// Toggle the favorite state of a certain item.
    func toggleIsFavorite(for item: Item) {
        service.toggleIsFavorite(for: item)
        favorites = getFavorites()
    }
}
