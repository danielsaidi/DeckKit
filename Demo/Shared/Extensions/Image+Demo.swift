//
//  Image+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-24.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension Image {

    static let favorite = symbol("heart")
    static let pageView = symbol("rectangle.split.3x1")
    static let shuffle = symbol("rectangle.portrait.on.rectangle.portrait.angled")
    static let stack = symbol("square.stack")

    static func symbol(_ name: String) -> Self {
        .init(systemName: name)
    }
}
