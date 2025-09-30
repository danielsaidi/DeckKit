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
public class FavoriteContext<Item: Identifiable>: ObservableObject {

    /// Create a default context instance.
    ///
    /// This instance uses a ``UserDefaultsFavoriteService``.
    public convenience init() {
        self.init(service: UserDefaultsFavoriteService<Item>())
    }

    /// Create a context with a custom service.
    ///
    /// - Parameters:
    ///   - service: The service to use to manage favorites.
    public init<Service: FavoriteService>(service: Service) where Service.Item == Item {
        self.favorites = service.getFavorites()
        self._getFavorites = service.getFavorites
        self._isFavorite = service.isFavorite
        self._setIsFavorite = service.setIsFavorite
        self._toggleIsFavorite = service.toggleIsFavorite
    }

    private let _getFavorites: () -> [Item.ID]
    private let _isFavorite: (Item) -> Bool
    private let _setIsFavorite: (Bool, Item) -> Void
    private let _toggleIsFavorite: (Item) -> Void


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
        _getFavorites()
    }
    
    /// Check if a certain item is marked as a favorite.
    func isFavorite(_ item: Item) -> Bool {
        _isFavorite(item)
    }
    
    /// Set the favorite state of a certain item.
    func setIsFavorite(_ isFavorite: Bool, for item: Item) {
        _setIsFavorite(isFavorite, item)
        favorites = getFavorites()
    }
    
    /// Toggle the favorite state of a certain item.
    func toggleIsFavorite(for item: Item) {
        _toggleIsFavorite(item)
        favorites = getFavorites()
    }
}
