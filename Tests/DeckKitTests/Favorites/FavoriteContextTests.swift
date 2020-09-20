//
//  FavoriteContextTests.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import XCTest
import DeckKit

final class FavoriteContextTests: XCTestCase {
    
    private lazy var service = TestService()
    private lazy var context = FavoriteContext<TestClass>(service: service)
    
    func testInitialValuesHaveValidStandardValues() {
        XCTAssertEqual(context.favorites, [])
        XCTAssertEqual(context.showOnlyFavorites, false)
    }
    
    func testInitialValuesPersistsChangedValues() {
        context.showOnlyFavorites = true
        let context2 = FavoriteContext<TestClass>(service: service)
        XCTAssertEqual(context2.showOnlyFavorites, true)
        context.showOnlyFavorites = false
    }
}

private class TestClass: Favoritable {
    
    let id: Int = 1
}

private class TestService: FavoriteService {
    
    func getFavorites<Item>(for type: Item.Type) -> [Item.ID] where Item: Favoritable { [] }
    func isFavorite<Item>(_ item: Item) -> Bool where Item: Favoritable { false }
    func setIsFavorite<Item>(_ isFavorite: Bool, for item: Item) where Item: Favoritable {}
    func toggleIsFavorite<Item>(for item: Item) where Item: Favoritable {}
}
