//
//  RoundButton.swift
//  Demo
//
//  Created by Daniel Saidi on 2022-11-29.
//  Copyright © 2022-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct RoundButton: View {

    init(
        text: String,
        image: String,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.image = image
        self.action = action
    }

    private let text: String
    private let image: String
    private let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: image)
                    .padding()
                    .background(badge)
                Text(text)
                    .font(.footnote)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

private extension RoundButton {

    var badge: some View {
        Circle()
            .fill(.white)
            .shadow(radius: 0, x: 0, y: 1)
    }
}
