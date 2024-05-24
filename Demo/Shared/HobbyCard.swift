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
        isShuffling: Bool
    ) {
        self.hobby = hobby
        self.isShuffling = isShuffling
    }
    
    private let hobby: Hobby
    private let isShuffling: Bool
    
    var body: some View {
        Card(
            isFlipped: isShuffling,
            front: front,
            back: back
        )
        .aspectRatio(0.65, contentMode: .fit)
    }
}

private extension HobbyCard {

    func front() -> some View {
        HobbyCardContent(hobby)
    }

    func back() -> some View {
        Image(.card)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()

        HobbyCard(.preview, isShuffling: false)
            .shadow(radius: 3, y: 2)
            .padding()
    }
}
