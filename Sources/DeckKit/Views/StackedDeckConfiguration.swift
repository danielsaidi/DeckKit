//
//  StackedDeckConfiguration.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This config can be used to configure a ``StackedDeck`` view.
 */
public struct StackedDeckConfiguration: Codable, Equatable {

    /**
     Create a stacked deck configuration.

     - Parameters:
       - direction: The visual direction of the stack, by default ``.up``.
       - cardDisplayCount: The max number of cards to display, by default `10`.
       - alwaysShowLastCard: Whether or not to show the last card for visual stability, by default `true`.
       - scaleOffset: The percentual factor to shrink cards for each step down the stack, by default `0.02`.
       - verticalOffset: The vertical offset to apply to cards for each step down the stack, by default `10`.
       - dragRotationFactor: The offset factor with which to rotate a card when it's panned, by default `0.05`.
       - horizontalDragThreshold: The number of points a card must be panned to be moved to the bottom of the deck, by default `100`.
       - verticalDragThreshold: The number of points a card must be panned to be moved to the bottom of the deck, by default `250`.
     */
    public init(
        direction: Direction = .up,
        cardDisplayCount: Int = 10,
        alwaysShowLastCard: Bool = true,
        scaleOffset: Double = 0.02,
        verticalOffset: Double = 10,
        dragRotationFactor: Double = 0.01,
        horizontalDragThreshold: Double = 100,
        verticalDragThreshold: Double = 250
    ) {
        assert(scaleOffset > 0, "scaleOffset must be positive")
        assert(verticalOffset > 0, "verticalOffset must be positive")
        self.direction = direction
        self.cardDisplayCount = cardDisplayCount
        self.alwaysShowLastCard = alwaysShowLastCard
        self.scaleOffset = scaleOffset
        self.verticalOffset = verticalOffset
        self.dragRotationFactor = dragRotationFactor
        self.horizontalDragThreshold = horizontalDragThreshold
        self.verticalDragThreshold = verticalDragThreshold
    }

    /// The visual direction of the stack.
    public var direction: Direction

    /// The max number of cards to display.
    public var cardDisplayCount: Int

    /// Whether or not to show the last card for visual stability.
    public var alwaysShowLastCard: Bool

    /// The percentual factor to shrink cards for each step down the stack.
    public var scaleOffset: Double

    /// The vertical offset to apply to cards for each step down the stack.
    public var verticalOffset: Double

    /// The offset factor with which to rotate a card when it's panned.
    public var dragRotationFactor: Double

    /// The number of points a card must be panned to be moved to the bottom of the deck.
    public var horizontalDragThreshold: Double

    /// The number of points a card must be panned to be moved to the bottom of the deck.
    public var verticalDragThreshold: Double
}

public extension StackedDeckConfiguration {

    /**
     A standard stacked deck configuration.
     */
    static var standard = StackedDeckConfiguration()
}

public extension StackedDeckConfiguration {

    /**
     The visual direction of a stack, where ``up`` means the
     stack seems to be growing upwards, while ``down`` means
     it seems to be growing downwards.
     */
    enum Direction: String, Codable {

        case up, down
    }
}
