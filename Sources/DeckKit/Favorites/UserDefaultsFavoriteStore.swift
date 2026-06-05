//
//  UserDefaultsFavoriteStore.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import Foundation

/// This service implements ``FavoriteStore`` by storing the
/// favorite state in `UserDefaults`.
public class UserDefaultsFavoriteStore<Item: Identifiable>: FavoriteStore {

    /// Create a service instance.
    public init(
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
    }
    
    private let defaults: UserDefaults
}

public extension UserDefaultsFavoriteStore {

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

private extension UserDefaultsFavoriteStore {

    var key: String {
        "com.danielsaidi.deckkit.favorites.\(String(describing: Item.self))"
    }
}
