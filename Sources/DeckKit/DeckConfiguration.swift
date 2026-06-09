//
//  DeckConfiguration.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to configure a ``Deck`` with a set
/// of customizations.
///
/// You can use the ``SwiftUICore/View/deckConfiguration(_:)``
/// view modifier to apply a custom deck configuration.
public struct DeckConfiguration: Codable, Equatable, Sendable {

    /// Create a deck view configuration.
    ///
    /// Note that `alwaysShowLastItem` will make sure that a
    /// deck always shows the last item in the bottom of the
    /// stack, even if it has more items. This makes swiping
    /// away a card look more consistent, since a card would
    /// otherwise fade away as it is swiped to the back.
    ///
    /// - Parameters:
    ///   - direction: The visual stack direction, by default `.down`.
    ///   - itemDisplayCount: The max number of items to display, by default `10`.
    ///   - alwaysShowLastItem: Whether to always show the last item, by default `true`.
    ///   - scaleOffset: The shrink factor to apply to each item down the deck, by default `0.02`.
    ///   - verticalOffset: The vertical offset to apply to each item down the deck, by default `10`.
    ///   - dragRotationFactor: The offset to rotation factor to apply when dragging items, by default `0.05`.
    ///   - horizontalDragThreshold: The number of points an item must be dragged to be moved last in the deck, by default `100`.
    ///   - verticalDragThreshold: The number of points an item must be dragged to be moved last in the deck, by default `250`.
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

    /// The visual stack direction.
    public var direction: Direction

    /// The max number of items to display.
    public var itemDisplayCount: Int

    /// Whether to always show the last item.
    public var alwaysShowLastItem: Bool

    /// The shrink factor to apply to each item down the deck.
    public var scaleOffset: Double

    /// The vertical offset to apply to each item down the deck.
    public var verticalOffset: Double

    /// The offset to rotation factor to apply when dragging items.
    public var dragRotationFactor: Double

    /// The number of points an item must be dragged to be moved last in the deck.
    public var horizontalDragThreshold: Double

    /// The number of points an item must be dragged to be moved last in the deck.
    public var verticalDragThreshold: Double
}

public extension DeckConfiguration {
    
    /// This is a standard deck view configuration.
    static var standard: Self { .init() }
}

public extension DeckConfiguration {

    /// This enum defines the visual direction of a deck.
    enum Direction: String, Codable, Sendable {
        case up, down
    }
}

public extension View {

    /// Apply a ``DeckConfiguration``.
    func deckConfiguration(
        _ config: DeckConfiguration
    ) -> some View {
        self.environment(\.deckConfiguration, config)
    }
}

public extension EnvironmentValues {

    /// Apply a ``DeckConfiguration``.
    @Entry var deckConfiguration = DeckConfiguration.standard
}
