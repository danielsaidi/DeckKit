//
//  Card.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-05-23.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view has a front view and can be flipped to show an
/// optional back view.
///
/// This view will only apply a corner radius and a rotation
/// effect to the view.
public struct Card<Front: View, Back: View>: View {

    /// Create a card view.
    ///
    /// - Parameters:
    ///   - isFlipped: Whether the card is flipped.
    ///   - cornerRadius: The corner radius, by default `20`.
    ///   - front: The front view.
    ///   - back: The back view.
    public init(
        isFlipped: Bool,
        cornerRadius: Double = 20,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back
    ) {
        self.front = front
        self.back = back
        self.cornerRadius = cornerRadius
        self.isFlipped = isFlipped
    }

    private let front: () -> Front
    private let back: () -> Back
    private let cornerRadius: Double
    private let isFlipped: Bool

    @Environment(\.colorScheme)
    private var colorScheme

    public var body: some View {
        front()
            .background(Color.card(for: colorScheme))
            .overlay { back().opacity(isFlipped ? 1 : 0) }
            .rotation3DEffect(isFlipped ? .degrees(180) : .zero, axis: (x: 0, y: 1, z: 0))
            .clipShape(.rect(cornerRadius: cornerRadius))
    }
}

#Preview {

    struct Preview: View {

        @State
        var isFlipped = false

        var body: some View {
            VStack {
                Card(
                    isFlipped: isFlipped,
                    cornerRadius: 20,
                    front: { Color.blue },
                    back: { Color.red }
                )

                Button("Flip") {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }
            }
        }
    }

    return Preview()
}
