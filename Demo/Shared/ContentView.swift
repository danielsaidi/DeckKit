//
//  ContentView.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

#if canImport(UIKit)
import UIKit
extension String {

    var image: UIImage? {
        .init(data: Data())
    }
}
#elseif canImport(AppKit)
extension String {

    var image: NSImage? {
        .init(data: Data())
    }
}
#endif


struct ContentView: View {

    @State
    var items = Hobby.demoCollection

    @State
    var selectedHobby: Hobby?

    @StateObject
    var shuffleAnimation = DeckShuffleAnimation()

    var body: some View {
        NavigationView {
            #if os(macOS)
            EmptyView()
            #endif
            ZStack {
                background
                deckView
                .padding()
            }
            .navigationTitle("DeckKit")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .safeAreaInset(edge: .bottom) {
                VStack {
                    shuffleButton
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
            }
            .sheet(item: $selectedHobby) {
                HobbyCardContent($0, inSheet: true)
            }
        }
    }
}

private extension ContentView {

    var background: some View {
        Color.gray.ignoresSafeArea()
    }

    var deckView: some View {
        DeckView(
            $items,
            shuffleAnimation: shuffleAnimation,
            swipeLeftAction: { hobby in print("\(hobby.id) was swiped left") },
            swipeRightAction: { selectedHobby = $0 },
            swipeUpAction: { hobby in print("\(hobby.id) was swiped up") },
            swipeDownAction: { hobby in print("\(hobby.id) was swiped down") },
            itemView: deckViewCard
        )
        .deckViewConfiguration(.init(
            direction: .down,
            itemDisplayCount: 5
        ))
    }
    
    func deckViewCard(for hobby: Hobby) -> some View {
        HobbyCard(hobby, isShuffling: shuffleAnimation.isShuffling)
    }

    var shuffleButton: some View {
        Button("Shuffle Deck") {
            shuffleAnimation.shuffle($items, times: 20)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
