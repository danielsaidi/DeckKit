//
//  DeckViewConfigurationTests.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import DeckKit
import XCTest

#if os(iOS) || os(macOS)
final class DeckViewConfigurationTests: XCTestCase {

    func testStandardInstanceUsesStandardValues() {
        let config = DeckViewConfiguration.standard
        XCTAssertEqual(config.direction, .down)
        XCTAssertEqual(config.itemDisplayCount, 10)
        XCTAssertEqual(config.alwaysShowLastItem, true)
        XCTAssertEqual(config.scaleOffset, 0.02)
        XCTAssertEqual(config.verticalOffset, 10)
        XCTAssertEqual(config.horizontalDragThreshold, 100)
        XCTAssertEqual(config.verticalDragThreshold, 250)
    }

    func testCustomInstanceUsesCustomValues() {
        let config = DeckViewConfiguration(
            direction: .down,
            itemDisplayCount: 20,
            alwaysShowLastItem: false,
            scaleOffset: 0.01,
            verticalOffset: 20,
            horizontalDragThreshold: 123,
            verticalDragThreshold: 456
        )
        XCTAssertEqual(config.direction, .down)
        XCTAssertEqual(config.itemDisplayCount, 20)
        XCTAssertEqual(config.alwaysShowLastItem, false)
        XCTAssertEqual(config.scaleOffset, 0.01)
        XCTAssertEqual(config.verticalOffset, 20)
        XCTAssertEqual(config.horizontalDragThreshold, 123)
        XCTAssertEqual(config.verticalDragThreshold, 456)
    }
}
#endif
