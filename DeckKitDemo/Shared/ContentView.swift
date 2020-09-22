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
    
    @State var deck = Deck(name: "Hobbies", items: Hobby.demoCollection)
    @State var isHorizontalList = false
    
    var body: some View {
        ZStack {
            background
            deckView.platformSpecificPadding()
            menuStack
        }
    }
}


// MARK: - Functions

private extension ContentView {
    
    func showAsHorizontalList() {
        isHorizontalList = true
    }
    
    func showAsStack() {
        isHorizontalList = false
    }
    
    func shuffle() {
        deck = Deck(name: deck.name, items: deck.items.shuffled())
        isHorizontalList.toggle()
        DispatchQueue.main.async {
            isHorizontalList.toggle()
        }
    }
}


// MARK: - View Logic

private extension ContentView {
    
    var background: some View {
        Color.gray
            .opacity(0.3)
            .edgesIgnoringSafeArea(.all)
    }
    
    var deckView: AnyView {
        if isHorizontalList {
            return AnyView(HorizontalDeck(deck: deck) {
                AnyView(HobbyCard(item: $0).padding())
            })
        } else {
            return AnyView(StackedDeck(
                deck: deck,
                direction: .up,
                displayCount: 10,
                alwaysShowLastCard: true,
                verticalOffset: 10) {
                AnyView(HobbyCard(item: $0))
            })
        }
    }
    
    var menu: some View {
        HStack(spacing: 20) {
            //menuButton(text: "Shuffle", image: "shuffle", action: shuffle)
            if isHorizontalList {
                menuButton(text: "Stack", image: "rectangle.stack", action: showAsStack)
            } else {
                menuButton(text: "List", image: "pause.fill", action: showAsHorizontalList)
            }
        }
    }
    
    func menuButton(text: String, image: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Circle()
                    .strokeBorder(Color.white, lineWidth: 1)
                    .background(Color.white.opacity(0.4).clipShape(Circle()))
                    .overlay(Image(systemName: image))
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 60)
                Text(text)
                    .font(.footnote)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .shadow(radius: 20)
    }
    
    var menuStack: some View {
        ZStack(alignment: .bottom) {
            Color.clear
            menu.padding()
        }
    }
}


// MARK: - View Extensions

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
