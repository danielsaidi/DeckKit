//
//  UserDefaultsFavoriteStoreTests.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2026-06-05.
//  Copyright © 2026 Daniel Saidi. All rights reserved.
//

import Testing

@testable import DeckKit

struct UserDefaultsFavoriteStoreTests {

    @Test
    func defaultStoreKey() {
        let store = UserDefaultsFavoriteStore<TestClass>()
        #expect(store.storeKey == "com.danielsaidi.deckkit.favorites.TestClass")
    }

    @Test
    func customStoreKey() {
        let store = UserDefaultsFavoriteStore<TestClass>(storeKeyPrefix: "com.custom.prefix.")
        #expect(store.storeKey == "com.custom.prefix.TestClass")
    }
}

private class TestClass: Identifiable {

    let id: Int = 1
}
