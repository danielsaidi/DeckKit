//
//  DeckShuffleAnimation.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2023-06-13.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This animation can be used to animate a deck shuffle.
///
/// To use the animation, inject a `@StateObject` into a ``DeckView`` and
/// use ``shuffle(_:times:)``.
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
        let times = times ?? 3
        if isShuffling { return }
        isShuffling = true
        for _ in 0...times {
            setRandomShuffleData(for: items.count)
            try? await Task.sleep(nanoseconds: 200_000_000)
        }
        items.wrappedValue.shuffle()
        setShuffleData([])
        isShuffling = false
    }
}

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
    
    func shuffleData<Item: Identifiable>(
        for item: Item,
        in items: [Item]
    ) -> ShuffleData? {
        guard
            shuffleData.count == items.count,
            let index = items.index(of: item)
        else { return nil }
        return shuffleData[index]
    }
}

@MainActor
extension View {

    /// Apply a shuffle animation to a deck item view.
    func deckShuffleAnimation<Item: Identifiable>(
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
