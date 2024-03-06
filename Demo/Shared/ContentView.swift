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
    var animation = DeckShuffleAnimation()
    
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
                HobbyCardContent(
                    item: $0,
                    inSheet: true
                )
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
            $items,
            config: .init(
                direction: .down,
                itemDisplayCount: 5
            ),
            shuffleAnimation: animation,
            swipeLeftAction: { hobby in print("\(hobby.id) was swiped left") },
            swipeRightAction: { selectedHobby = $0 },
            swipeUpAction: { hobby in print("\(hobby.id) was swiped up") },
            swipeDownAction: { hobby in print("\(hobby.id) was swiped down") },
            itemView: deckViewCard
        )
    }
    
    func deckViewCard(for hobby: Hobby) -> some View {
        HobbyCard(
            item: hobby,
            isShuffling: animation.isShuffling
        )
    }

    var background: some View {
        Color.gray
            .opacity(0.3)
            .edgesIgnoringSafeArea(.all)
    }

    var shuffleButton: some View {
        Button("Shuffle Deck") {
            animation.shuffle($items, times: 20)
        }
        .buttonStyle(.borderedProminent)
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
