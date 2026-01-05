//
//  HobbyCardImageHeader.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-24.
//  Copyright © 2024-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCardImageHeader: View {

    let hobby: Hobby

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(hobby.color.gradient)
            .frame(height: 150)
            .overlay(imageView)
    }
}

private extension HobbyCardImageHeader {

    var imageView: some View {
        hobby.image
            .font(.largeTitle)
            .padding()
            .background(Circle().fill(.thinMaterial))
    }
}

#Preview {
    HobbyCardImageHeader(hobby: .preview)
        .padding()
}
