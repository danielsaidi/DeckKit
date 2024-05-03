//
//  DeckShuffleAnimation.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2023-06-13.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This animation can be used to animate deck shuffling.
///
/// To use this way of animating deck shuffles, first create
/// a `@StateObject` instance in a view that should use this
/// animation, then inject it into any view that supports it,
/// like the ``DeckView``.
///
/// Once a view is configured with a shuffle animation, call
/// ``DeckShuffleAnimation/shuffle(_:times:)`` with any list
/// of items to shuffle the list.
@MainActor
public final class DeckShuffleAnimation: ObservableObject {

    /// Create a deck shuffle animation.
    ///
    /// - Parameters:
    ///   - maxDegrees: The max rotation to apply to the cards, by default `6`.
    ///   - maxOffsetX: The max x offset to apply to the cards, by default `6`.
    ///   - maxOffsetY: The max y offset to apply to the cards, by default `6`.
    public init(
        maxDegrees: Double = 6,
        maxOffsetX: Double = 6,
        maxOffsetY: Double = 6
    ) {
        self.maxDegrees = maxDegrees
        self.maxOffsetX = maxOffsetX
        self.maxOffsetY = maxOffsetY
    }

    /// The max rotation to apply to the cards.
    public let maxDegrees: Double

    /// The max x offset to apply to the cards.
    public let maxOffsetX: Double

    /// The max y offset to apply to the cards.
    public let maxOffsetY: Double

    /// Whether or not the animation is currently shuffling.
    public var isShuffling = false
    
    @Published
    private var shuffleData: [ShuffleData] = []
}

private struct ShuffleData: Sendable {

    public let angle: Angle
    public let xOffset: Double
    public let yOffset: Double
}

@MainActor
public extension View {

    /// Apply a shuffle animation to a deck item view.
    func withShuffleAnimation<Item: DeckItem>(
        _ animation: DeckShuffleAnimation,
        for item: Item,
        in items: [Item]
    ) -> some View {
        let data = animation.shuffleData(for: item, in: items)
        return self
            .rotationEffect(data?.angle ?? .zero)
            .offset(x: data?.xOffset ?? 0, y: data?.yOffset ?? 0)
    }
}

public extension DeckShuffleAnimation {
    
    /// Shuffle the provided deck with a shuffle animation.
    ///
    /// - Parameters:
    ///   - items: The items to shuffle.
    ///   - times: The number of times to shuffle, by default `3`.
    func shuffle<Item>(
        _ items: Binding<[Item]>,
        times: Int = 3
    ) {
        Task {
            await shuffleAsync(items, times: times)
        }
    }
    
    /// Shuffle the provided deck with a shuffle animation.
    ///
    /// - Parameters:
    ///   - items: The items to shuffle.
    ///   - times: The number of times to shuffle, by default `3`.
    func shuffleAsync<Item>(
        _ items: Binding<[Item]>,
        times: Int = 3
    ) async {
        if isShuffling { return }
        isShuffling = true
        let itemCount = items.count
        for index in 0...times {
            let isLast = index == times
            let multiplier = isLast ? 0.5 : 1
            setShuffleData((0..<itemCount).map { _ in
                ShuffleData(
                    angle: Angle.degrees(multiplier * Double.random(in: -maxDegrees...maxDegrees)),
                    xOffset: multiplier * Double.random(in: -maxOffsetX...maxOffsetX),
                    yOffset: multiplier * Double.random(in: -maxOffsetY...maxOffsetY)
                )
            })
            try? await Task.sleep(nanoseconds: 200_000_000)
        }
        items.wrappedValue.shuffle()
        setShuffleData((0..<itemCount).map { _ in
            ShuffleData(
                angle: Angle.degrees(0),
                xOffset: 0,
                yOffset: 0
            )
        })
        isShuffling = false
    }
}

@MainActor
private extension DeckShuffleAnimation {
    
    func setShuffleData(_ data: [ShuffleData]) {
        withAnimation {
            self.shuffleData = data
        }
    }
    
    func shuffleData<Item: DeckItem>(
        for item: Item,
        in items: [Item]
    ) -> ShuffleData? {
        guard
            shuffleData.count == items.count,
            let index = items.firstIndex(of: item)
        else { return nil }
        return shuffleData[index]
    }
}
