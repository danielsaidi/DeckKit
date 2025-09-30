//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-09-30.
//

import DeckKit
import SwiftUI

struct ContentView: View {

    @State var allHobbies = Hobby.demoCollection
    @State var hobbies = Hobby.demoCollection
    @State var sheetHobby: Hobby?

    @StateObject var favoriteContext = FavoriteContext<Hobby>()
    @StateObject var shuffleAnimation = DeckShuffleAnimation(animation: .bouncy)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                DeckView(
                    $hobbies,
                    shuffleAnimation: shuffleAnimation,
                    swipeAction: { edge, hobby in
                        guard edge == .trailing else { return }
                        self.sheetHobby = hobby
                    }
                ) { hobby in
                    HobbyCard(
                        hobby: hobby,
                        isFavorite: favoriteContext.isFavorite(hobby),
                        isFlipped: shuffleAnimation.isShuffling,
                        favoriteAction: favoriteContext.toggleIsFavorite
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
                    isFavorite: favoriteContext.isFavorite(hobby),
                    isFlipped: false,
                    favoriteAction: favoriteContext.toggleIsFavorite
                )
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: shuffle) { Image.shuffle }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: toggleFavorites) { Image.favorite }
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
        favoriteContext.showOnlyFavorites
    }

    func isFavorite(_ hobby: Hobby) -> Bool {
        favoriteContext.isFavorite(hobby)
    }

    func shuffle() {
        allHobbies.shuffle()
        shuffleAnimation.shuffle($hobbies, times: 5)
    }

    func toggleFavorites() {
        favoriteContext.showOnlyFavorites.toggle()
        hobbies = showOnlyFavorites ? favoriteHobbies : allHobbies
        hobbies = showOnlyFavorites ? favoriteHobbies : allHobbies
    }
}

#Preview {
    ContentView()
}
