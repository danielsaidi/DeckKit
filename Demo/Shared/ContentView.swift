//
//  ContentView.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct ContentView: View {

    @State
    var deck = Deck(
        name: "Hobbies",
        items: Hobby.demoCollection
    )

    @State
    var selectedHobby: Hobby?

    @State
    var isShuffling = false

    @State
    var shuffleDegrees = Self.getShuffleDegrees()

    @State
    var shuffleOffsetsY = Self.getShuffleOffsets()

    @State
    var shuffleOffsetsX = Self.getShuffleOffsets()
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            EmptyView()
            #endif
            VStack(spacing: 50) {
                deckView.withPlatformPadding()
                shuffleButton
            }
            .sheet(item: $selectedHobby) {
                HobbyCardContent(item: $0, inSheet: true)
            }
            .navigationTitle("DeckKit")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .padding()
            .background(background)
        }
    }
}

private extension ContentView {

    var deckView: some View {
        DeckView(
            deck: $deck,
            config: .init(
                direction: .down,
                itemDisplayCount: 5
            ),
            swipeLeftAction: { hobby in print("\(hobby.id) was swiped left") },
            swipeRightAction: { selectedHobby = $0 },
            swipeUpAction: { hobby in print("\(hobby.id) was swiped up") },
            swipeDownAction: { hobby in print("\(hobby.id) was swiped down") },
            itemView: card
        )
    }

    var background: some View {
        Color.gray
            .opacity(0.3)
            .edgesIgnoringSafeArea(.all)
    }

    var shuffleButton: some View {
        RoundButton(
            text: "Shuffle",
            image: "shuffle",
            action: shuffle
        )
    }

    func card(for hobby: Hobby) -> some View {
        let data = shuffleData(for: hobby)
        return HobbyCard(item: hobby)
            .rotationEffect(data.0)
            .offset(x: data.1, y: data.2)
    }
}

private extension ContentView {

    func shuffle() {
        withAnimation {
            isShuffling = true
            performAfterDelay(shuffleSecond)
        }
    }

    func shuffleSecond() {
        withAnimation {
            isShuffling = false
            performAfterDelay(shuffleThird)
        }
    }

    func shuffleThird() {
        withAnimation {
            randomizeShuffleData()
            isShuffling = true
            performAfterDelay(shuffleDeck)
        }
    }

    func shuffleDeck() {
        deck.shuffle()
        performAfterDelay(endShuffle)
    }

    func endShuffle() {
        withAnimation {
            isShuffling = false
            randomizeShuffleData()
        }
    }

    func randomizeShuffleData() {
        shuffleDegrees = Self.getShuffleDegrees()
        shuffleOffsetsX = Self.getShuffleOffsets()
        shuffleOffsetsY = Self.getShuffleOffsets()
    }

    func performAfterDelay(_ action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: action)
    }

    func shuffleData(for hobby: Hobby) -> (Angle, Double, Double)  {
        guard
            isShuffling,
            let index = deck.items.firstIndex(of: hobby)
        else { return (.zero, 0, 0) }
        let degrees = Angle.degrees(shuffleDegrees[index])
        let offsetX = shuffleOffsetsX[index]
        let offsetY = shuffleOffsetsY[index]
        return (degrees, offsetX, offsetY)
    }

    static func getShuffleDegrees() -> [Double] {
        (0...100).map { _ in
            Double.random(in: -8...8)
        }
    }

    static func getShuffleOffsets() -> [Double] {
        (0...100).map { _ in
            Double.random(in: -8...8)
        }
    }
}

extension View {
    
    func withPlatformPadding() -> some View {
        #if os(macOS)
        return self.padding(.vertical, 100)
        #else
        return self
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
