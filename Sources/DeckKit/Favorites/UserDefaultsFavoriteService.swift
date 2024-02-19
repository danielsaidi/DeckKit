//
//  UserDefaultsFavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class implements ``FavoriteService`` by persisting the
 favorite state in `UserDefaults`.
 */
public class UserDefaultsFavoriteService: FavoriteService {
    
    /// Create a service instance.
    public init(
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
    }
    
    private let defaults: UserDefaults
}

public extension UserDefaultsFavoriteService {
    
    func getFavorites<Item: Identifiable>(for type: Item.Type) -> [Item.ID] {
        let key = self.key(for: type)
        return defaults.array(forKey: key) as? [Item.ID] ?? []
    }
    
    func isFavorite<Item: Identifiable>(_ item: Item) -> Bool {
        getFavorites(for: Item.self).contains(item.id)
    }
    
    func setIsFavorite<Item: Identifiable>(_ isFavorite: Bool, for item: Item) {
        var favorites = getFavorites(for: Item.self)
        if isFavorite {
            favorites.append(item.id)
        } else {
            favorites.removeAll { $0 == item.id }
        }
        defaults.set(favorites, forKey: key(for: Item.self))
    }
    
    func toggleIsFavorite<Item: Identifiable>(for item: Item) {
        setIsFavorite(!isFavorite(item), for: item)
    }
}

private extension UserDefaultsFavoriteService {
    
    func key<Item: Identifiable>(for type: Item.Type) -> String {
        "com.danielsaidi.deckkit.favorites.\(String(describing: type))"
    }
}
