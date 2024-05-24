//
//  HobbyCardContent.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import DeckKit
import SwiftUI

struct HobbyCardContent: View {

    init(
        _ hobby: Hobby,
        inSheet: Bool = false
    ) {
        self.hobby = hobby
        self.inSheet = inSheet
    }

    private let hobby: Hobby
    private let inSheet: Bool
    private let numberSize = 60.0

    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(hobby.color, lineWidth: 1)
                .padding(numberSize/2)
                .overlay(cardContent.padding(numberSize))
            Circle()
                .fill(.clear)
                .frame(width: numberSize, height: numberSize)
                .overlay(numberView)
        }
        .multilineTextAlignment(.center)
        .fontDesign(.serif)
        .cornerRadius(10)
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

    var numberView: some View {
        Text("\(hobby.number)")
            .font(.title2)
            .fontWeight(.bold)
            .padding()
            .background(Color.card(for: colorScheme))
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
    
    HobbyCardContent(.preview)
}
