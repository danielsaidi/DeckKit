//
//  HobbyCardContent.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCardContent: View {

    init(
        item: Hobby,
        inSheet: Bool = false
    ) {
        self.item = item
        self.inSheet = inSheet
    }

    private let item: Hobby
    private let inSheet: Bool

    private let numberSize = 60.0

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(item.color, lineWidth: 1)
                .padding(numberSize/2)
                .overlay(cardContent.padding(numberSize))
            Circle()
                .fill(.clear)
                .frame(width: numberSize, height: numberSize)
                .overlay(numberView)
        }
        .multilineTextAlignment(.center)
        .fontDesign(.serif)
        .background(Color.white)
        .cornerRadius(10)
    }
}

private extension HobbyCardContent {

    var cardContent: some View {
        VStack(spacing: 30) {
            imageHeader
            title
            text
            Spacer()
            Divider()
            footnote
        }
    }

    var imageHeader: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(item.color.gradient)
            .frame(height: 150)
            .padding()
            .overlay(imageView)
    }

    var imageView: some View {
        item.image
            .font(.largeTitle)
            .padding()
            .background(imageBadge)
    }

    var imageBadge: some View {
        Circle()
            .fill(.regularMaterial)
    }

    var numberView: some View {
        Text("\(item.number)")
            .font(.title2)
            .fontWeight(.bold)
            .padding()
            .background(Circle().fill(.white))
    }

    var title: some View {
        Text(item.name)
            .font(.title)
            .fontWeight(.bold)
            .minimumScaleFactor(0.8)
    }

    var text: some View {
        Text(item.text)
            .font(.body)
            .fixedSize(horizontal: false, vertical: true)
    }

    var footnote: some View {
        Text(inSheet ? "Swipe down to close" : "Swipe left for a new hobby, swipe right to select this one.")
            .font(.footnote)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct HobbyCardContent_Previews: PreviewProvider {
    static let hobbies = Hobby.demoCollection

    static var previews: some View {
        HobbyCardContent(
            item: hobbies.randomElement() ?? hobbies[0]
        )
    }
}
