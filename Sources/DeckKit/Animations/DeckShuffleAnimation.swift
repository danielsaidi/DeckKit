//
//  DeckShuffleAnimation.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2023-06-13.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
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

    /**
     Apply a shuffle animation to a deck item view.
     */
    func withShuffleAnimation<Item>(
        _ animation: DeckShuffleAnimation,
        for item: Item,
        in deck: Deck<Item>
    ) -> some View {
        let data = animation.shuffleData(for: item, in: deck)
        return self.rotationEffect(data?.angle ?? .zero)
            .offset(x: data?.xOffset ?? 0, y: data?.yOffset ?? 0)
            .animation(.default, value: animation.animationTrigger)
    }
}

public extension DeckShuffleAnimation {

    /**
     Shuffle the provided deck with a shuffle animation.

     - Parameters:
       - deck: The deck to shuffle.
       - times: The number of times to shuffle the deck, by default `5`.
     */
    func shuffle<Item>(
        _ deck: Binding<Deck<Item>>,
        times: Int = 3
    ) {
        if animationTrigger { return }
        randomizeShuffleData(for: deck)
        shuffle(deck, times: times, time: 1)
    }

    /**
     Get the current shuffle data for a certain deck item.
     */
    func shuffleData<Item>(
        for item: Item,
        in deck: Deck<Item>
    ) -> ShuffleData? {
        guard
            shuffleData.count == deck.items.count,
            let index = deck.items.firstIndex(of: item)
        else { return nil }
        return shuffleData[index]
    }
}

private extension DeckShuffleAnimation {

    func performAfterDelay(_ action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: action)
    }

    func randomizeShuffleData<Item>(for deck: Binding<Deck<Item>>) {
        shuffleData = (0..<deck.wrappedValue.items.count).map { _ in
            ShuffleData(
                angle: Angle.degrees(Double.random(in: -maxDegrees...maxDegrees)),
                xOffset: Double.random(in: -maxOffsetX...maxOffsetX),
                yOffset: Double.random(in: -maxOffsetY...maxOffsetY)
            )
        }
    }

    func shuffle<Item>(
        _ deck: Binding<Deck<Item>>,
        times: Int,
        time: Int
    ) {
        animationTrigger.toggle()
        performAfterDelay {
            if time < times {
                self.randomizeShuffleData(for: deck)
                self.shuffle(deck, times: times, time: time + 1)
            } else {
                self.easeOutShuffleState(for: deck)
            }
        }
    }

    func easeOutShuffleState<Item>(for deck: Binding<Deck<Item>>) {
        shuffleData = shuffleData.map {
            ShuffleData(
                angle: $0.angle/2,
                xOffset: $0.xOffset/2,
                yOffset: $0.yOffset/2
            )
        }
        animationTrigger.toggle()
        performAfterDelay {
            self.resetShuffleState(for: deck)
        }
    }

    func resetShuffleState<Item>(for deck: Binding<Deck<Item>>) {
        animationTrigger.toggle()
        shuffleData = []
        performAfterDelay {
            deck.wrappedValue.shuffle()
            self.animationTrigger = false
        }
    }
}
