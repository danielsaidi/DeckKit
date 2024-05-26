//
//  DemoToolbar.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-26.
//

import SwiftUI

struct DemoToolbar: View {

    var isShowOnlyFavoritesActive: Bool
    var isShuffleActive: Bool
    var favoritesAction: () -> Void
    var shuffleAction: () -> Void

    var body: some View {
        HStack {
            toolbarShuffleButton
            toolbarFavoriteButton
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(.thickMaterial)
        .clipShape(.capsule)
        .compositingGroup()
    }
}

private extension DemoToolbar {

    var toolbarFavoriteButton: some View {
        toolbarButton(
            "Toggle Favorite",
            .favorite,
            action: favoritesAction
        )
        .symbolVariant(isShowOnlyFavoritesActive ? .fill : .none)
        .tint(isShowOnlyFavoritesActive ? .red : .accentColor)
    }

    var toolbarShuffleButton: some View {
        toolbarButton(
            "Shuffle",
            .shuffle,
            action: shuffleAction
        )
        .symbolVariant(isShuffleActive ? .fill : .none)
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
        isShowOnlyFavoritesActive: true,
        isShuffleActive: false,
        favoritesAction: {},
        shuffleAction: {}
    )
}
