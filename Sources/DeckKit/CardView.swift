//
//  CardView.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-05-23.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This view has a front and a back view and can be flipped by swiping or tapping.
public struct CardView<Front: View, Back: View>: View {

    /// Create a card view.
    ///
    /// - Parameters:
    ///   - isFlipped: Whether the card is flipped.
    ///   - front: The front view.
    ///   - back: The back view.
    public init(
        isFlipped: Bool,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back
    ) {
        self.front = front
        self.back = back
        self.isFlipped = isFlipped
    }

    private let front: () -> Front
    private let back: () -> Back
    private let isFlipped: Bool

    @Environment(\.colorScheme)
    private var colorScheme

    public var body: some View {
        front()
            .overlay(
                back()
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .opacity(isFlipped ? 1 : 0))
            .padding(100)
            .rotation3DEffect(isFlipped ? .degrees(180) : .zero, axis: (x: 0, y: 1, z: 0))
            .padding(-100)
    }
}

#Preview {

    struct Preview: View {

        @State
        var isFlipped = false

        var body: some View {
            VStack {
                CardView(
                    isFlipped: isFlipped,
                    front: {
                        Color.blue
                            .overlay(Text("Front"))
                            .withCornerRadius()
                    },
                    back: {
                        Color.yellow
                            .overlay(Text("Back"))
                            .withCornerRadius()
                    }
                )
                .aspectRatio(0.65, contentMode: .fit)

                Button("Flip") {
                    withAnimation {
                        isFlipped.toggle()
                    }
                }
            }
            .padding()
        }
    }

    return Preview()
}

private extension View {
    
    func withCornerRadius() -> some View {
        self.clipShape(.rect(cornerRadius: 20))
    }
}
