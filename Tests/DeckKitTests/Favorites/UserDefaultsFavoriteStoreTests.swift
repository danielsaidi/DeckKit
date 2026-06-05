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
    func usesExpectedStoreKey() {
        let store = UserDefaultsFavoriteStore<TestClass>()
        #expect(store.storeKey == "com.deckkit.favorites.TestClass")
    }
}

private class TestClass: Identifiable {

    let id: Int = 1
}
