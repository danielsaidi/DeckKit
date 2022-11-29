//
//  HobbyCardContent.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCardContent: View {

    init(item: Hobby) {
        self.item = item
    }

    private let item: Hobby

    var body: some View {
        VStack(spacing: 20) {
            title
            Divider()
            Spacer()
            image
            text
            Spacer()
            footnote
        }
        .padding(30)
        .foregroundColor(item.foregroundColor)
        .background(item.backgroundColor)
        .background(Color.white)
    }
}

extension HobbyCardContent {

    var title: some View {
        Text(item.name)
            .font(.title)
            .withDemoShadow()
    }

    var image: some View {
        item.image
            .font(.title)
            .padding()
            .background(imageBadge)
            .withDemoShadow()
    }

    var imageBadge: some View {
        Circle().fill(Color.white.opacity(0.2))
    }

    var text: some View {
        Text(item.text)
            .font(.body)
            .multilineTextAlignment(.center)
            .withDemoShadow()
    }

    var footnote: some View {
        Text("Swipe for a new hobby")
            .font(.footnote)
            .padding(.top)
    }
}

struct HobbyCardContent_Previews: PreviewProvider {
    static let hobbies = Hobby.demoCollection

    static var previews: some View {
        HobbyCardContent(
            item: hobbies.randomElement() ?? hobbies[0]
        )
        .padding()
        .shadow(radius: 0.3)
        .background(Color.blue.ignoresSafeArea())
    }
}
