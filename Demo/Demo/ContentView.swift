//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-09-30.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct ContentView: View {

    @State var allHobbies = Hobby.demoCollection
    @State var hobbies = Hobby.demoCollection
    @State var sheetHobby: Hobby?

    @State var favorites = FavoriteContext<Hobby>()
    @State var shuffle = DeckShuffleAnimation(animation: .bouncy)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                Deck(
                    $hobbies,
                    shuffleAnimation: shuffle,
                    swipeAction: { edge, hobby in
                        guard edge == .trailing else { return }
                        openHobbyInSheet(hobby)
                    }
                ) { hobby in
                    HobbyCard(
                        hobby: hobby,
                        isFavorite: favorites.isFavorite(hobby),
                        isFlipped: shuffle.isShuffling,
                        favoriteAction: favorites.toggleIsFavorite
                    )
                }
                .padding()
            }
            .navigationTitle("DeckKit")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .sheet(item: $sheetHobby) { hobby in
                HobbyCard(
                    hobby: hobby,
                    isFavorite: favorites.isFavorite(hobby),
                    isFlipped: false,
                    favoriteAction: favorites.toggleIsFavorite
                )
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: shuffleDeck) {
                        Image.shuffle
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: toggleFavorites) {
                        Image.favorite
                    }
                    .tint(.red)
                    .symbolVariant(showOnlyFavorites ? .fill : .none)
                }
            }
        }
    }
}

private extension ContentView {

    var favoriteHobbies: [Hobby] {
        allHobbies.filter(isFavorite)
    }

    var showOnlyFavorites: Bool {
        favorites.showOnlyFavorites
    }

    func isFavorite(_ hobby: Hobby) -> Bool {
        favorites.isFavorite(hobby)
    }

    func openHobbyInSheet(_ hobby: Hobby) {
        sheetHobby = hobby
        hobbies.moveLastItemToFront()
    }

    func shuffleDeck() {
        allHobbies.shuffle()
        shuffle.shuffle($hobbies, times: 5)
    }

    func toggleFavorites() {
        withAnimation {
            favorites.showOnlyFavorites.toggle()
            hobbies = showOnlyFavorites ? favoriteHobbies : allHobbies
        }
    }
}

#Preview {
    ContentView()
}
