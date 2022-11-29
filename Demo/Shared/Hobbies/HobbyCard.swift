//
//  HobbyCard.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCard: View {
    
    init(
        item: Hobby,
        cornerRadius: CGFloat = 10) {
        self.item = item
        self.cornerRadius = cornerRadius
    }
    
    private let item: Hobby
    private let cornerRadius: CGFloat
    
    var body: some View {
        HobbyCardContent(item: item)
            .cornerRadius(cornerRadius)
    }
}

struct HobbyCard_Previews: PreviewProvider {
    static let hobbies = Hobby.demoCollection

    static var previews: some View {
        HobbyCard(
            item: hobbies.randomElement() ?? hobbies[0]
        )
        .padding()
        .shadow(radius: 0.3)
        .background(Color.blue.ignoresSafeArea())
    }
}
