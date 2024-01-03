//
//  FavoriteContext.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This observable object context can be used to bind favorite
 state to your views.
 */
public class FavoriteContext<Item: Favoritable>: ObservableObject, FavoriteService {
    
    /**
     Create a favorite context.
     
     - Parameters:
       - service: The service to use to manage favorites, by default a ``UserDefaultsFavoriteService``.
     */
    public init(service: FavoriteService = UserDefaultsFavoriteService()) {
        self.service = service
        self.favorites = getFavorites(for: Item.self)
        self.showOnlyFavorites = showOnlyFavoritesSetting
    }
    
    private let service: FavoriteService
    
    
    /**
     The item IDs that are currently markes as favorite.
     */
    @Published
    public private(set) var favorites: [Item.ID] = []
    
    /**
     Whether or not to only show favorites.
     */
    @Published
    public var showOnlyFavorites: Bool = false {
        didSet { showOnlyFavoritesSetting = showOnlyFavorites }
    }
    
    @UserDefaultsPersisted(key: "com.deckkit.favorites.showonlyfavorites", defaultValue: false)
    private var showOnlyFavoritesSetting: Bool
    
    
    /**
     Get the raw list of favorites from the embedded service.
     */
    public func getFavorites<ItemType: Favoritable>(for type: ItemType.Type) -> [ItemType.ID] {
        service.getFavorites(for: ItemType.self)
    }
    
    /**
     Check whether or not a certain item is a favorite.
     */
    public func isFavorite<ItemType: Favoritable>(_ item: ItemType) -> Bool {
        service.isFavorite(item)
    }
    
    /**
     Set whether or not a certain item is a favorite.
     */
    public func setIsFavorite<ItemType: Favoritable>(_ isFavorite: Bool, for item: ItemType) {
        service.setIsFavorite(isFavorite, for: item)
        favorites = getFavorites(for: ItemType.self) as? [Item.ID] ?? []
    }
    
    /**
     Toggle whether or not a certain item is a favorite.
     */
    public func toggleIsFavorite<ItemType: Favoritable>(for item: ItemType) {
        service.toggleIsFavorite(for: item)
        favorites = getFavorites(for: ItemType.self) as? [Item.ID] ?? []
    }
}
