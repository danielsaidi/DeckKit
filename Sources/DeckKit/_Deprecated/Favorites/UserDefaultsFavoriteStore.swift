//
//  UserDefaultsFavoriteStore.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "This class has been moved to https://github.com/danielsaidi/SwiftUIKit")
public final class UserDefaultsFavoriteStore<Item: Identifiable>: FavoriteStore {

    /// Create a service instance.
    ///
    /// - Parameters:
    ///   - defaults: The user defaults instance to use.
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        migrateIfNeeded()
    }

    private let defaults: UserDefaults
}

@available(*, deprecated, message: "This class has been moved to https://github.com/danielsaidi/SwiftUIKit")
public extension UserDefaultsFavoriteStore {

    func getFavorites() -> [Item.ID] {
        defaults.array(forKey: storeKey) as? [Item.ID] ?? []
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
        defaults.set(favorites, forKey: storeKey)
    }
    
    func toggleIsFavorite(for item: Item) {
        setIsFavorite(!isFavorite(item), for: item)
    }
}

@available(*, deprecated, message: "This class has been moved to https://github.com/danielsaidi/SwiftUIKit")
extension UserDefaultsFavoriteStore {

    var storeKey: String {
        "com.deckkit.favorites.\(String(describing: Item.self))"
    }
}

@available(*, deprecated, message: "This class has been moved to https://github.com/danielsaidi/SwiftUIKit")
private extension UserDefaultsFavoriteStore {

    var legacyKey: String {
        "com.danielsaidi.deckkit.favorites.\(String(describing: Item.self))"
    }

    func migrateIfNeeded() {
        guard
            defaults.object(forKey: storeKey) == nil,
            let legacy = defaults.object(forKey: legacyKey)
        else { return }
        defaults.set(legacy, forKey: storeKey)
        defaults.removeObject(forKey: legacyKey)
    }
}
