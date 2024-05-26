//
//  DemoToolbar.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-26.
//

import SwiftUI

struct DemoToolbar: View {

    var hasFavorites: Bool
    var hasMultipleCards: Bool
    var isFavoritesActive: Bool
    var isPageViewActive: Bool
    var isShuffleActive: Bool
    var favoritesAction: () -> Void
    var pageViewAction: () -> Void
    var shuffleAction: () -> Void

    var body: some View {
        HStack {
            shuffleButton
            pageViewButton
            favoriteButton
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(.thickMaterial)
        .clipShape(.capsule)
        .compositingGroup()
    }
}

private extension DemoToolbar {

    var favoriteButton: some View {
        toolbarButton(
            "Toggle Favorite",
            .favorite,
            action: favoritesAction
        )
        .disabled(!hasFavorites)
        .symbolVariant(isFavoritesActive ? .fill : .none)
        .tint(isFavoritesActive ? .red : .accentColor)
    }

    var shuffleButton: some View {
        toolbarButton(
            "Shuffle",
            .shuffle,
            action: shuffleAction
        )
        .disabled(!hasMultipleCards)
        .symbolVariant(isShuffleActive ? .fill : .none)
    }

    var pageViewButton: some View {
        toolbarButton(
            "Toggle page view",
            .pageView,
            action: pageViewAction
        )
        .symbolVariant(isPageViewActive ? .fill : .none)
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

#Preview {
    DemoToolbar(
        hasFavorites: true,
        hasMultipleCards: true,
        isFavoritesActive: true,
        isPageViewActive: true,
        isShuffleActive: true,
        favoritesAction: {},
        pageViewAction: {},
        shuffleAction: {}
    )
}
