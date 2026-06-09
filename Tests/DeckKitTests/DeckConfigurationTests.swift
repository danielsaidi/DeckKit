//
//  DeckConfigurationTests.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import DeckKit
import Testing

#if os(iOS) || os(macOS)
@Suite struct DeckConfigurationTests {

    @Test func standardInstanceUsesStandardValues() {
        let config = DeckConfiguration.standard
        #expect(config.direction == .down)
        #expect(config.itemDisplayCount == 10)
        #expect(config.alwaysShowLastItem == true)
        #expect(config.scaleOffset == 0.02)
        #expect(config.verticalOffset == 10)
        #expect(config.horizontalDragThreshold == 100)
        #expect(config.verticalDragThreshold == 250)
    }

    @Test func customInstanceUsesCustomValues() {
        let config = DeckConfiguration(
            direction: .down,
            itemDisplayCount: 20,
            alwaysShowLastItem: false,
            scaleOffset: 0.01,
            verticalOffset: 20,
            horizontalDragThreshold: 123,
            verticalDragThreshold: 456
        )
        #expect(config.direction == .down)
        #expect(config.itemDisplayCount == 20)
        #expect(config.alwaysShowLastItem == false)
        #expect(config.scaleOffset == 0.01)
        #expect(config.verticalOffset == 20)
        #expect(config.horizontalDragThreshold == 123)
        #expect(config.verticalDragThreshold == 456)
    }

    @Test func instanceCanBeModified() {
        var config = DeckConfiguration.standard
        config.alwaysShowLastItem = false
        #expect(config.alwaysShowLastItem == false)
    }
}
#endif
