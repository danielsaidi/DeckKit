//
//  FavoriteService.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

/**
 This protocol can be implemented by anything that can be markes as a favorite.
 */
public protocol Favoritable: Identifiable {}

/**
 This protocol can be implemented by classes that can mark items as favorites.
 */
public protocol FavoriteService: AnyObject {
    
    func getFavorites<Item: Favoritable>(for type: Item.Type) -> [Item.ID]
    func isFavorite<Item: Favoritable>(_ item: Item) -> Bool
    func setIsFavorite<Item: Favoritable>(_ isFavorite: Bool, for item: Item)
}
