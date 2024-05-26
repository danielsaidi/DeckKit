//
//  HobbyCard.swift
//  Demo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct HobbyCard: View {
    
    init(
        _ hobby: Hobby,
        isFavorite: Bool = false,
        isFlipped: Bool = false,
        favoriteAction: ((Hobby) -> Void)? = nil
    ) {
        self.hobby = hobby
        self.isFavorite = isFavorite
        self.isFlipped = isFlipped
        self.favoriteAction = favoriteAction ?? { _ in }
    }
    
    private let hobby: Hobby
    private let isFavorite: Bool
    private let isFlipped: Bool
    private let favoriteAction: (Hobby) -> Void

    var body: some View {
        Card(
            isFlipped: isFlipped,
            front: front,
            back: back
        )
        .aspectRatio(0.65, contentMode: .fit)
    }
}

private extension HobbyCard {

    func front() -> some View {
        HobbyCardContent(
            hobby,
            isFavorite: isFavorite,
            favoriteAction: favoriteAction
        )
    }

    func back() -> some View {
        Color.white
            .overlay(backImage)
    }

    var backImage: some View {
        Image(.card)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#Preview {

    struct Preview: View {

        @State
        var isFlipped = false

        var body: some View {
            ZStack {
                Color.background.ignoresSafeArea()
                HobbyCard(
                    .preview,
                    isFavorite: true,
                    isFlipped: false
                )
                .padding()
            }
        }
    }

    return Preview()
}
