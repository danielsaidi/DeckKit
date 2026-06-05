//
//  FavoriteContextTests.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-09-17.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import DeckKit
import Testing

struct FavoriteContextTests {

    @Test
    func initialValuesHaveValidStandardValues() {
        let context = FavoriteContext(store: TestStore<TestClass>())
        #expect(context.favorites == [])
        #expect(context.showOnlyFavorites == false)
    }

    @Test
    @MainActor
    func initialValuesPersistsChangedValues() {
        let store = TestStore<TestClass>()
        let context = FavoriteContext(store: store)
        context.showOnlyFavorites = true
        let context2 = FavoriteContext(store: store)
        #expect(context2.showOnlyFavorites == true)
        context.showOnlyFavorites = false
    }
}

private class TestClass: Identifiable {

    let id: Int = 1
}

private class TestStore<Item: Identifiable>: FavoriteStore {

    func getFavorites() -> [Item.ID] { [] }
    func isFavorite(_ item: Item) -> Bool { false }
    func setIsFavorite(_ isFavorite: Bool, for item: Item) {}
    func toggleIsFavorite(for item: Item) {}
}
