//
//  HobbyCard.swift
//  Demo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2026 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct HobbyCard: View {
    
    let hobby: Hobby
    let isFavorite: Bool
    let isFlipped: Bool
    let favoriteAction: (Hobby) -> Void

    var body: some View {
        CardView(
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
            hobby: hobby,
            isFavorite: isFavorite,
            favoriteAction: favoriteAction
        )
        .clipped()
    }

    func back() -> some View {
        Color.white
            .overlay(backImage)
            .clipped()
    }

    var backImage: some View {
        Image(.card)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

private extension View {

    func clipped() -> some View {
        self.clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {

    @Previewable @State var isFavorite = false
    @Previewable @State var isFlipped = false

    ZStack {
        Color.background.ignoresSafeArea()
        HobbyCard(
            hobby: .preview,
            isFavorite: isFavorite,
            isFlipped: isFlipped,
            favoriteAction: { _ in isFavorite.toggle() }
        )
        .onTapGesture {
            withAnimation(.bouncy) {
                isFlipped.toggle()
            }
        }
        .padding()
    }
}
