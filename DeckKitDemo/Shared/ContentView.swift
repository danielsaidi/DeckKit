//
//  ContentView.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI
import DeckKit

struct ContentView: View {
    
    var deck: Deck<Hobby> {
        Deck(name: "Hobbies", items: Hobby.demoCollection)
    }
    
    var body: some View {
        StackedDeck(
            deck: deck,
            direction: .up,
            displayCount: 10,
            alwaysShowLastCard: true,
            verticalOffset: 10) { hobby in
            AnyView(HobbyCard(item: hobby))
        }.platformSpecificPadding()
    }
}

extension View {
    
    func platformSpecificPadding() -> some View {
        #if os(macOS)
        return self.padding(100)
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
