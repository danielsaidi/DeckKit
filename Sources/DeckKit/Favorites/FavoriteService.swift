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
    
    /**
     Get all favorite item IDs.
     */
    func getFavorites<Item: Favoritable>(for type: Item.Type) -> [Item.ID]
    
    /**
     Check whether or not a certain item is a favorite.
     */
    func isFavorite<Item: Favoritable>(_ item: Item) -> Bool
    
    /**
     Set whether or not a certain item is a favorite.
     */
    func setIsFavorite<Item: Favoritable>(_ isFavorite: Bool, for item: Item)
    
    /**
     Toggle whether or not a certain item is a favorite.
     */
    func toggleIsFavorite<Item: Favoritable>(for item: Item)
}
