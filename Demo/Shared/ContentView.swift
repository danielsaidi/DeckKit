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

    @State
    var usePageView = false

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
                        hasFavorites: favoriteContext.hasFavorites,
                        hasMultipleCards: hobbies.count > 1,
                        isFavoritesActive: showOnlyFavorites,
                        isPageViewActive: usePageView,
                        isShuffleActive: isShuffling,
                        favoritesAction: toggleShowOnlyFavorites,
                        pageViewAction: toggleUsePageView,
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

    func card(for hobby: Hobby) -> some View {
        HobbyCard(
            hobby,
            isFavorite: favoriteContext.isFavorite(hobby),
            isFlipped: isShuffling,
            favoriteAction: favoriteContext.toggleIsFavorite
        )
    }

    @ViewBuilder
    var deckView: some View {
        if usePageView {
            DeckPageView($hobbies) { hobby in
                card(for: hobby)
                    .padding()
            }
        } else {
            DeckView(
                $hobbies,
                shuffleAnimation: shuffleAnimation,
                swipeLeftAction: { print("\($0.id) was swiped left") },
                swipeRightAction: { selectedHobby = $0 },
                swipeUpAction: { print("\($0.id) was swiped up") },
                swipeDownAction: { print("\($0.id) was swiped down") },
                itemView: card
            )
            .deckViewConfiguration(.init(
                direction: .down,
                itemDisplayCount: 5
            ))
            .padding()
        }
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

    func toggleUsePageView() {
        usePageView.toggle()
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
