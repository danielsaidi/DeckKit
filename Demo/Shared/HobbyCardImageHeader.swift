//
//  HobbyCardImageHeader.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-24.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCardImageHeader: View {

    init(_ hobby: Hobby) {
        self.hobby = hobby
    }

    private let hobby: Hobby

    private let numberSize = 60.0

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
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
    HobbyCardImageHeader(.preview)
        .padding()
}
