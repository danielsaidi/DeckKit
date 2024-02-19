//
//  FavoriteContextTests.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import DeckKit
import XCTest

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

private class TestClass: Identifiable {
    
    let id: Int = 1
}

private class TestService: FavoriteService {
    
    func getFavorites<Item: Identifiable>(for type: Item.Type) -> [Item.ID] { [] }
    func isFavorite<Item: Identifiable>(_ item: Item) -> Bool { false }
    func setIsFavorite<Item: Identifiable>(_ isFavorite: Bool, for item: Item) {}
    func toggleIsFavorite<Item: Identifiable>(for item: Item) {}
}
