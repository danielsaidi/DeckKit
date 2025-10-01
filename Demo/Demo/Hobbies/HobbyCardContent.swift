//
//  HobbyCardContent.swift
//  Demo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct HobbyCardContent: View {

    let hobby: Hobby
    let isFavorite: Bool
    let favoriteAction: (Hobby) -> Void

    private let circleSize = 50.0

    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(hobby.color, lineWidth: 1)
                .padding(circleSize/2)
            cardContent
                .padding(circleSize)
            HStack {
                cardNumber
                Spacer()
                favoriteButton
            }
            .font(.title2)
        }
        .padding()
        .background(Color.primary.colorInvert())
        .multilineTextAlignment(.center)
        .fontDesign(.serif)
        .environment(\.sizeCategory, .medium)
    }
}

private extension HobbyCardContent {

    var cardContent: some View {
        VStack(spacing: 30) {
            HobbyCardImageHeader(hobby: hobby)
            title
            text
            Spacer()
            Divider()
            footnote
        }
    }

    var cardNumber: some View {
        edgeBadge {
            Text("\(hobby.number)").bold()
        }
    }

    var favoriteButton: some View {
        edgeBadge {
            Button {
                favoriteAction(hobby)
            } label: {
                Image.favorite
                    .symbolVariant(isFavorite ? .fill : .none)
                    .symbolEffect(.wiggle, value: isFavorite)
            }
            .tint(.red)
        }
    }

    var title: some View {
        Text(hobby.name)
            .font(.title)
            .fontWeight(.bold)
            .minimumScaleFactor(0.8)
            .lineLimit(1)
    }

    var text: some View {
        Text(hobby.text)
            .lineLimit(4, reservesSpace: true)
    }

    var footnote: some View {
        Text("Swipe left for a new hobby, swipe right to select this one.")
            .font(.footnote)
            .fixedSize(horizontal: false, vertical: true)
    }

    func edgeBadge<Content: View>(
        content: () -> Content
    ) -> some View {
        Circle()
            .fill(.white)
            .frame(width: circleSize, height: circleSize)
            .overlay { content() }
    }
}

#Preview {

    @Previewable @State var isFavorite = false

    HobbyCardContent(
        hobby: .preview,
        isFavorite: isFavorite,
        favoriteAction: { _ in isFavorite.toggle() }
    )
    .padding()
    .background(Color.primary.opacity(0.1))
}
