//
//  HobbyCard.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct HobbyCard: View {
    
    init(
        _ hobby: Hobby,
        isShuffling: Bool,
        isFavorite: Bool = false,
        favoriteAction: ((Hobby) -> Void)? = nil
    ) {
        self.hobby = hobby
        self.isShuffling = isShuffling
        self.isFavorite = isFavorite
        self.favoriteAction = favoriteAction ?? { _ in }
    }
    
    private let hobby: Hobby
    private let isShuffling: Bool
    private let isFavorite: Bool
    private let favoriteAction: (Hobby) -> Void

    var body: some View {
        Card(
            isFlipped: isShuffling,
            front: front,
            back: back
        )
    }
}

private extension HobbyCard {

    func front() -> some View {
        HobbyCardContent(
            hobby,
            isFavorite: isFavorite,
            favoriteAction: favoriteAction
        )
        .aspectRatio(0.65, contentMode: .fit)
    }

    func back() -> some View {
        Color.white
            .overlay(backImage)
            .aspectRatio(0.65, contentMode: .fit)
    }

    var backImage: some View {
        Image(.card)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    ZStack {
        Color.background.ignoresSafeArea()
        HobbyCard(.preview, isShuffling: false)
            .padding()
    }
}
