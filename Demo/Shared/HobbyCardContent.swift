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

    init(
        _ hobby: Hobby,
        inSheet: Bool = false,
        isFavorite: Bool = false,
        favoriteAction: ((Hobby) -> Void)? = nil
    ) {
        self.hobby = hobby
        self.inSheet = inSheet
        self.isFavorite = isFavorite
        self.favoriteAction = favoriteAction ?? { _ in }
    }

    private let hobby: Hobby
    private let inSheet: Bool
    private let isFavorite: Bool
    private let favoriteAction: (Hobby) -> Void

    private let circleSize = 60.0

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
        .multilineTextAlignment(.center)
        .fontDesign(.serif)
        .environment(\.sizeCategory, .medium)
    }
}

private extension HobbyCardContent {

    var cardContent: some View {
        VStack(spacing: 30) {
            HobbyCardImageHeader(hobby)
            title
            text
            Spacer()
            Divider()
            footnote
        }
    }

    var cardNumber: some View {
        circle.overlay {
            Text("\(hobby.number)")
                .bold()
        }
    }

    var circle: some View {
        Circle()
            .fill(Color.card(for: colorScheme))
            .frame(width: circleSize, height: circleSize)
    }

    var favoriteButton: some View {
        circle.overlay {
            Button {
                favoriteAction(hobby)
            } label: {
                Image.favorite
                    .foregroundStyle(isFavorite ? .red : .primary)
                    .symbolVariant(isFavorite ? .fill : .none)
            }
        }
    }

    var title: some View {
        Text(hobby.name)
            .font(.title)
            .fontWeight(.bold)
            .minimumScaleFactor(0.8)
    }

    var text: some View {
        Text(hobby.text)
            .fixedSize(horizontal: false, vertical: true)
    }

    var footnote: some View {
        Text(inSheet ? "Swipe down to close" : "Swipe left for a new hobby, swipe right to select this one.")
            .font(.footnote)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {

    struct Preview: View {

        @State
        var isFavorite = false

        var body: some View {
            HobbyCardContent(
                .preview,
                isFavorite: isFavorite,
                favoriteAction: { _ in isFavorite.toggle() }
            )
        }
    }

    return Preview()
}
