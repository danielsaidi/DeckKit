//
//  UserDefaultsFavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This class implements ``FavoriteService`` by persisting the
 favorite state in `UserDefaults`.
 */
public class UserDefaultsFavoriteService: FavoriteService {
    
    /**
     Create a service instance.
     
     - Parameters:
       - defaults: The store to persist data in.
     */
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    
    private let defaults: UserDefaults
    
    
    /**
     Get all favorite item IDs.
     */
    public func getFavorites<Item: Favoritable>(for type: Item.Type) -> [Item.ID] {
        let key = self.key(for: type)
        return defaults.array(forKey: key) as? [Item.ID] ?? []
    }
    
    /**
     Check whether or not a certain item is a favorite.
     */
    public func isFavorite<Item: Favoritable>(_ item: Item) -> Bool {
        getFavorites(for: Item.self).contains(item.id)
    }
    
    /**
     Set whether or not a certain item is a favorite.
     */
    public func setIsFavorite<Item: Favoritable>(_ isFavorite: Bool, for item: Item) {
        var favorites = getFavorites(for: Item.self)
        if isFavorite {
            favorites.append(item.id)
        } else {
            favorites.removeAll { $0 == item.id }
        }
        defaults.set(favorites, forKey: key(for: Item.self))
    }
    
    /**
     Toggle whether or not a certain item is a favorite.
     */
    public func toggleIsFavorite<Item: Favoritable>(for item: Item) {
        setIsFavorite(!isFavorite(item), for: item)
    }
}

private extension UserDefaultsFavoriteService {
    
    func key<Item: Favoritable>(for type: Item.Type) -> String {
        "com.danielsaidi.deckkit.favorites.\(String(describing: type))"
    }
}
