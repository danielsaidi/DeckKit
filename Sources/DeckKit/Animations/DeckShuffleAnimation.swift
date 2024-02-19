//
//  DeckShuffleAnimation.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2023-06-13.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This animation can be used to animate deck shuffling.

 To use this animation, first create a `@StateObject` in the
 view that should use the animation, then bind the animation
 to your item views, using a `withShuffleAnimation` modifier,
 then call `shuffle` to perform an animated shuffle.
 */
public class DeckShuffleAnimation: ObservableObject {

    /**
     Create a deck shuffle animation.

     - Parameters:
       - maxDegrees: The max rotation to apply to the cards, by default `6`.
       - maxOffsetX: The max x offset to apply to the cards, by default `6`.
       - maxOffsetY: The max y offset to apply to the cards, by default `6`.
     */
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
    public var isShuffling: Bool {
        !shuffleData.isEmpty
    }

    @Published
    fileprivate var animationTrigger = false
    
    @Published
    private var shuffleData: [ShuffleData] = []


    /// This data type defines shuffle rotation and offsets.
    public struct ShuffleData {

        public let angle: Angle
        public let xOffset: Double
        public let yOffset: Double
    }
}

public extension View {

    /// Apply a shuffle animation to a deck item view.
    func withShuffleAnimation<Item: DeckItem>(
        _ animation: DeckShuffleAnimation,
        for item: Item,
        in items: [Item]
    ) -> some View {
        let data = animation.shuffleData(for: item, in: items)
        return self.rotationEffect(data?.angle ?? .zero)
            .offset(x: data?.xOffset ?? 0, y: data?.yOffset ?? 0)
            .animation(.default, value: animation.animationTrigger)
    }
}

public extension DeckShuffleAnimation {
    
    /// Shuffle the provided deck with a shuffle animation.
    ///
    /// - Parameters:
    ///   - deck: The deck to shuffle.
    ///   - times: The number of times to shuffle, by default `3`.
    func shuffle<Item>(
        _ items: Binding<[Item]>,
        times: Int = 3
    ) {
        if animationTrigger { return }
        randomizeShuffleData(for: items)
        shuffle(items, times: times, time: 1)
    }
}

private extension DeckShuffleAnimation {

    func performAfterDelay(_ action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: action)
    }

    func randomizeShuffleData<Item>(
        for items: Binding<[Item]>
    ) {
        shuffleData = (0..<items.count).map { _ in
            ShuffleData(
                angle: Angle.degrees(Double.random(in: -maxDegrees...maxDegrees)),
                xOffset: Double.random(in: -maxOffsetX...maxOffsetX),
                yOffset: Double.random(in: -maxOffsetY...maxOffsetY)
            )
        }
    }

    func shuffle<Item>(
        _ items: Binding<[Item]>,
        times: Int,
        time: Int
    ) {
        animationTrigger.toggle()
        performAfterDelay {
            if time < times {
                self.randomizeShuffleData(for: items)
                self.shuffle(items, times: times, time: time + 1)
            } else {
                self.easeOutShuffleState(for: items)
            }
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

    func easeOutShuffleState<Item>(
        for items: Binding<[Item]>
    ) {
        shuffleData = shuffleData.map {
            ShuffleData(
                angle: $0.angle/2,
                xOffset: $0.xOffset/2,
                yOffset: $0.yOffset/2
            )
        }
        animationTrigger.toggle()
        performAfterDelay {
            self.resetShuffleState(for: items)
        }
    }

    func resetShuffleState<Item>(
        for items: Binding<[Item]>
    ) {
        animationTrigger.toggle()
        shuffleData = []
        performAfterDelay {
            items.wrappedValue.shuffle()
            self.animationTrigger = false
        }
    }
}
