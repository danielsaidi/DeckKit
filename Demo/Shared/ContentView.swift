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
            .onChange(of: showOnlyFavorites) {
                if $0 {
                    hobbies = Hobby.demoCollection.filter { favoriteContext.isFavorite($0) }
                } else {
                    hobbies = Hobby.demoCollection
                }
            }
            .onReceiveShake(action: shuffleDeck)
            .sheet(item: $selectedHobby) {
                HobbyCardContent($0, inSheet: true)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    shuffleButton
                }
                ToolbarItem(placement: .confirmationAction) {
                    favoriteButton
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

    var favoriteButton: some View {
        toolbarButton("Toggle Favorite", .favorite, action: toggleShowOnlyFavorites)
            .symbolVariant(showOnlyFavorites ? .fill : .none)
    }

    var shuffleButton: some View {
        toolbarButton("Shuffle", .shuffle, action: shuffleDeck)
            .symbolVariant(isShuffling ? .fill : .none)
    }

    func deckViewCard(for hobby: Hobby) -> some View {
        HobbyCard(
            hobby,
            isShuffling: isShuffling,
            isFavorite: favoriteContext.isFavorite(hobby),
            favoriteAction: favoriteContext.toggleIsFavorite
        )
    }

    func toolbarButton(
        _ title: String,
        _ icon: Image,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Label(
                title: { Text(title) },
                icon: { icon }
            )
        }
    }
}

private extension ContentView {

    var isShuffling: Bool {
        shuffleAnimation.isShuffling
    }

    func shuffleDeck() {
        shuffleAnimation.shuffle($hobbies, times: 20)
    }

    func toggleIsFavorite() {
        guard let hobby = hobbies.first else { return }
        favoriteContext.toggleIsFavorite(for: hobby)
    }

    func toggleShowOnlyFavorites() {
        showOnlyFavorites.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
