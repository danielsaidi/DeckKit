//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct ContentView: View {

    @State
    var hobbies = Hobby.demoCollection

    @State
    var selectedHobby: Hobby?

    @State
    var showOnlyFavorites = false

    @StateObject
    var favoriteContext = FavoriteContext<Hobby, UserDefaultsFavoriteService>()

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
            .onChange(of: showOnlyFavorites, perform: updateHobbies)
            .onReceiveShake(action: shuffleDeck)
            .sheet(item: $selectedHobby) {
                HobbyCardContent($0, inSheet: true)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    DemoToolbar(
                        isShowOnlyFavoritesActive: showOnlyFavorites,
                        isShuffleActive: isShuffling,
                        favoritesAction: toggleShowOnlyFavorites,
                        shuffleAction: shuffleDeck
                    )
                }
            }
        }
    }
}

private extension ContentView {

    var background: some View {
        Color.background.ignoresSafeArea()
    }

    var deckView: some View {
        DeckView(
            $hobbies,
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
        HobbyCard(
            hobby,
            isFavorite: favoriteContext.isFavorite(hobby),
            isFlipped: isShuffling,
            favoriteAction: favoriteContext.toggleIsFavorite
        )
    }
}

private extension ContentView {

    var isShuffling: Bool {
        shuffleAnimation.isShuffling
    }

    func shuffleDeck() {
        shuffleAnimation.shuffle($hobbies, times: 5)
    }

    func toggleIsFavorite() {
        guard let hobby = hobbies.first else { return }
        withAnimation {
            favoriteContext.toggleIsFavorite(for: hobby)
        }
    }

    func toggleShowOnlyFavorites() {
        showOnlyFavorites.toggle()
    }

    func updateHobbies(showOnlyFavorites: Bool) {
        if showOnlyFavorites {
            hobbies = Hobby.demoCollection.filter { favoriteContext.isFavorite($0) }
        } else {
            hobbies = Hobby.demoCollection
        }
    }
}

#Preview {
    ContentView()
}
