//
//  FavoriteContext.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This observable object can be used to bind favorite state
 to your views.
 */
public class FavoriteContext<Item: Favoritable>: ObservableObject, FavoriteService {
    
    public init(service: FavoriteService) {
        self.service = service
        self.favorites = getFavorites(for: Item.self)
        self.showOnlyFavorites = showOnlyFavoritesSetting
    }
    
    private let service: FavoriteService
    
    @Published public var favorites: [Item.ID] = []
    @Published public var showOnlyFavorites: Bool = false {
        didSet { showOnlyFavoritesSetting = showOnlyFavorites }
    }
    
    @UserDefaultsPersisted(key: "showonlyfavorites", defaultValue: false)
    private var showOnlyFavoritesSetting: Bool
    
    public func getFavorites<ItemType: Favoritable>(for type: ItemType.Type) -> [ItemType.ID] {
        service.getFavorites(for: ItemType.self)
    }
    
    public func isFavorite<ItemType: Favoritable>(_ item: ItemType) -> Bool {
        service.isFavorite(item)
    }
    
    public func setIsFavorite<ItemType: Favoritable>(_ isFavorite: Bool, for item: ItemType) {
        service.setIsFavorite(isFavorite, for: item)
        favorites = getFavorites(for: ItemType.self) as? [Item.ID] ?? []
    }
    
    public func toggleIsFavorite<ItemType: Favoritable>(for item: ItemType) {
        service.toggleIsFavorite(for: item)
        favorites = getFavorites(for: ItemType.self) as? [Item.ID] ?? []
    }
}
