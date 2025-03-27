//
//  UserDefaultsFavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

/// This type implements the ``FavoriteService`` protocol by
/// storing the favorite state within `UserDefaults`.
public class UserDefaultsFavoriteService<Item: Identifiable>: FavoriteService {

    /// Create a service instance.
    public init(
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
    }
    
    private let defaults: UserDefaults
}

public extension UserDefaultsFavoriteService {
    
    func getFavorites() -> [Item.ID] {
        defaults.array(forKey: key) as? [Item.ID] ?? []
    }
    
    func isFavorite(_ item: Item) -> Bool {
        getFavorites().contains(item.id)
    }
    
    func setIsFavorite(_ isFavorite: Bool, for item: Item) {
        var favorites = getFavorites()
        if isFavorite {
            favorites.append(item.id)
        } else {
            favorites.removeAll { $0 == item.id }
        }
        defaults.set(favorites, forKey: key)
    }
    
    func toggleIsFavorite(for item: Item) {
        setIsFavorite(!isFavorite(item), for: item)
    }
}

private extension UserDefaultsFavoriteService {
    
    var key: String {
        "com.danielsaidi.deckkit.favorites.\(String(describing: Item.self))"
    }
}
