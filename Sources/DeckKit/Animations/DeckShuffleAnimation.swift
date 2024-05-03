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
    ///   - animation: The animation to use, by default `default`.
    ///   - maxDegrees: The max rotation to apply to the cards, by default `6`.
    ///   - maxOffsetX: The max x offset to apply to the cards, by default `6`.
    ///   - maxOffsetY: The max y offset to apply to the cards, by default `6`.
    public init(
        animation: Animation = .default,
        maxDegrees: Double = 6,
        maxOffsetX: Double = 6,
        maxOffsetY: Double = 6
    ) {
        self.animation = animation
        self.maxDegrees = maxDegrees
        self.maxOffsetX = maxOffsetX
        self.maxOffsetY = maxOffsetY
    }
    
    /// The animation to use.
    public let animation: Animation
    
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
    
    @available(*, deprecated, renamed: "deckShuffleAnimation(_:for:in:)")
    func withShuffleAnimation<Item: DeckItem>(
        _ animation: DeckShuffleAnimation,
        for item: Item,
        in items: [Item]
    ) -> some View {
        deckShuffleAnimation(animation, for: item, in: items)
    }
    
    /// Apply a shuffle animation to a deck item view.
    func deckShuffleAnimation<Item: DeckItem>(
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
        times: Int? = nil
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
        times: Int? = nil
    ) async {
        if isShuffling { return }
        isShuffling = true
        let itemCount = items.count
        for _ in 0...(times ?? 3) {
            setRandomShuffleData(for: itemCount)
            try? await Task.sleep(nanoseconds: 200_000_000)
        }
        items.wrappedValue.shuffle()
        setShuffleData([])
        isShuffling = false
    }
}

@MainActor
private extension DeckShuffleAnimation {
    
    func setRandomShuffleData(for itemCount: Int) {
        setShuffleData(
            (0..<itemCount).map { _ in
                .init(
                    angle: Angle.degrees(Double.random(in: -maxDegrees...maxDegrees)),
                    xOffset: Double.random(in: -maxOffsetX...maxOffsetX),
                    yOffset: Double.random(in: -maxOffsetY...maxOffsetY)
                )
            }
        )
    }
    
    func setShuffleData(_ data: [ShuffleData]) {
        withAnimation(animation) {
            shuffleData = data
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
