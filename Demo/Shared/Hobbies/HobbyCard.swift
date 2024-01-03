//
//  HobbyCard.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCard: View {
    
    init(
        item: Hobby,
        isShuffling: Bool
    ) {
        self.item = item
        self.isShuffling = isShuffling
    }
    
    private let item: Hobby
    private let isShuffling: Bool
    
    var body: some View {
        HobbyCardContent(
            item: item,
            isShuffling: isShuffling
        )
        .cornerRadius(10)
    }
}

#Preview {
    
    HobbyCard(
        item: Hobby.demoCollection.previewItem,
        isShuffling: false
    )
    .padding()
    .shadow(radius: 0.3)
    .background(Color.blue.ignoresSafeArea())
}
