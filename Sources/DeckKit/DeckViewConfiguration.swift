//
//  DeckViewConfiguration.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to configure a ``DeckView``.
///
/// You can use the ``SwiftUI/View/deckViewConfiguration(_:)``
/// view modifier to apply a custom configuration.
public struct DeckViewConfiguration: Codable, Equatable, Sendable {

    /// Create a deck view configuration.
    ///
    /// Note that `alwaysShowLastItem` will make sure that a
    /// deck always shows the last item in the bottom of the
    /// stack, even if it has more items. This makes swiping
    /// away a card look more consistent, since a card would
    /// otherwise fade away as it is swiped to the back.
    ///
    /// - Parameters:
    ///   - direction: The visual direction of the stack, by default `.down`.
    ///   - itemDisplayCount: The max number of items to display, by default `10`.
    ///   - alwaysShowLastItem: Whether or not to show the last item for visual stability, by default `true`.
    ///   - scaleOffset: The percentual shrink factor to apply to each item in the stack, by default `0.02`.
    ///   - verticalOffset: The vertical offset to apply to each item in the stack, by default `10`.
    ///   - dragRotationFactor: The offset factor with which to rotate an item when it's panned, by default `0.05`.
    ///   - horizontalDragThreshold: The number of points an item must be panned to be moved to the bottom of the deck, by default `100`.
    ///   - verticalDragThreshold: The number of points an item must be panned to be moved to the bottom of the deck, by default `250`.
    public init(
        direction: Direction = .down,
        itemDisplayCount: Int = 10,
        alwaysShowLastItem: Bool = true,
        scaleOffset: Double = 0.02,
        verticalOffset: Double = 10,
        dragRotationFactor: Double = 0.05,
        horizontalDragThreshold: Double = 100,
        verticalDragThreshold: Double = 250
    ) {
        assert(scaleOffset > 0, "scaleOffset must be positive")
        assert(verticalOffset > 0, "verticalOffset must be positive")
        self.direction = direction
        self.itemDisplayCount = itemDisplayCount
        self.alwaysShowLastItem = alwaysShowLastItem
        self.scaleOffset = scaleOffset
        self.verticalOffset = verticalOffset
        self.dragRotationFactor = dragRotationFactor
        self.horizontalDragThreshold = horizontalDragThreshold
        self.verticalDragThreshold = verticalDragThreshold
    }

    /// The visual direction of the stack.
    public var direction: Direction

    /// The max number of items to display.
    public var itemDisplayCount: Int

    /// Whether or not to show the last item for visual stability.
    public var alwaysShowLastItem: Bool

    /// The percentual shrink factor to apply to each item in the stack.
    public var scaleOffset: Double

    /// The vertical offset to apply to each item in the stack.
    public var verticalOffset: Double

    /// The offset factor with which to rotate an item when it's panned.
    public var dragRotationFactor: Double

    /// The number of points an item must be panned to be moved to the bottom of the deck.
    public var horizontalDragThreshold: Double

    /// The number of points an item must be panned to be moved to the bottom of the deck.
    public var verticalDragThreshold: Double
}

public extension DeckViewConfiguration {
    
    /// This is a standard deck view configuration.
    static var standard: Self { .init() }
}

public extension DeckViewConfiguration {

    /// This enum defines the visual direction of a deck.
    enum Direction: String, Codable, Sendable {
        case up, down
    }
}

public extension View {

    /// Apply a ``DeckViewConfiguration``.
    func deckViewConfiguration(
        _ config: DeckViewConfiguration
    ) -> some View {
        self.environment(\.deckViewConfiguration, config)
    }
}

public extension EnvironmentValues {

    /// Apply a ``DeckViewConfiguration``.
    @Entry var deckViewConfiguration = DeckViewConfiguration.standard
}
