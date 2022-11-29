//
//  HobbyCard.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCard: View {
    
    init(item: Hobby) {
        self.item = item
    }
    
    private let item: Hobby
    
    var body: some View {
        HobbyCardContent(item: item)
            .cornerRadius(10)
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
