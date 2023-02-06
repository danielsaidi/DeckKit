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
        items: Hobby.demoCollection)

    @State
    var hobby: Hobby?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                deckView.withPlatformPadding()
                shuffleButton
            }
            .sheet(item: $hobby) {
                HobbyCardContent(item: $0, inSheet: true)
            }
            .navigationTitle("DeckKit")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .background(background)
        }

    }
}


// MARK: - Functions

private extension ContentView {
    
    func shuffle() {
        deck.items.shuffle()
    }
}


// MARK: - Decks

private extension ContentView {

    @ViewBuilder
    var deckView: some View {
        DeckView(
            deck: $deck,
            config: .init(
                direction: .down,
                itemDisplayCount: 5
            ),
            swipeLeftAction: { hobby in print("\(hobby.id) was swiped left") },
            swipeRightAction: { self.hobby = $0 },
            swipeUpAction: { hobby in print("\(hobby.id) was swiped up") },
            swipeDownAction: { hobby in print("\(hobby.id) was swiped down") },
            itemView: HobbyCard.init
        )
    }
}


// MARK: - View Logic

private extension ContentView {
    
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
}


// MARK: - View Extensions

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
