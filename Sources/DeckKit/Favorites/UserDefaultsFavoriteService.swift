//
//  UserDefaultsFavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class stores favorite state in user defaults.
 */
public class UserDefaultsFavoriteService: FavoriteService {
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    private let defaults: UserDefaults
    
    public func getFavorites<Item: Favoritable>(for type: Item.Type) -> [Item.ID] {
        let key = self.key(for: type)
        return defaults.array(forKey: key) as? [Item.ID] ?? []
    }
    
    public func isFavorite<Item: Favoritable>(_ item: Item) -> Bool {
        getFavorites(for: Item.self).contains(item.id)
    }
    
    public func setIsFavorite<Item: Favoritable>(_ isFavorite: Bool, for item: Item) {
        var favorites = getFavorites(for: Item.self)
        isFavorite ? favorites.append(item.id) : favorites.removeAll { $0 == item.id }
        defaults.set(favorites, forKey: key(for: Item.self))
    }
    
    public func toggleIsFavorite<Item: Favoritable>(for item: Item) {
        setIsFavorite(!isFavorite(item), for: item)
    }
}

private extension UserDefaultsFavoriteService {
    
    func key<Item: Favoritable>(for type: Item.Type) -> String {
        "com.danielsaidi.deckkit.favorites.\(String(describing: type))"
    }
}
