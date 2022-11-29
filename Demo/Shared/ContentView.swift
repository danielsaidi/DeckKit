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

    enum StackType: String {
        case stacked, horizontal
    }
    
    @State
    var deck = Deck(
        name: "Hobbies",
        items: Hobby.demoCollection)
    
    @State
    var stackType = StackType.stacked
    
    var body: some View {
        VStack(spacing: 20) {
            picker
                .padding()
            deckView.withPlatformPadding()
            shuffleButton
        }
        .background(background)
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
        switch stackType {
        case .horizontal:
            horizontalDeck
        case .stacked:
            stackedDeck
        }
    }

    var horizontalDeck: some View {
        GeometryReader { geo in
            HorizontalDeck(deck: $deck) {
                card(for: $0)
                    .frame(width: geo.size.width - 30)
                    .padding(.horizontal)
            }
        }
    }

    var stackedDeck: some View {
        StackedDeck(
            deck: $deck,
            config: .standard,
            swipeLeftAction: { hobby in print("\(hobby.id) was swiped left") },
            swipeRightAction: { hobby in print("\(hobby.id) was swiped right") },
            swipeUpAction: { hobby in print("\(hobby.id) was swiped up") },
            swipeDownAction: { hobby in print("\(hobby.id) was swiped down") },
            cardBuilder: card
        )
        .padding(.horizontal)
        .padding(.top, 40)
    }
}


// MARK: - View Logic

private extension ContentView {
    
    var background: some View {
        Color.gray
            .opacity(0.3)
            .edgesIgnoringSafeArea(.all)
    }
    
    func card(for hobby: Hobby) -> some View {
        HobbyCard(item: hobby)
    }

    var picker: some View {
        Picker("Pick style", selection: $stackType) {
            pickerItem(for: .stacked)
            pickerItem(for: .horizontal)
        }.pickerStyle(.segmented)
    }

    func pickerItem(for type: StackType) -> some View {
        Text(type.rawValue.capitalized)
            .tag(type)
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
