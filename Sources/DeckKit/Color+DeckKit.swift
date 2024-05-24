//
//  Color+DeckKit.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-05-24.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Color {

    /// A standard card background color, which is white for
    /// apps in light mode, and black in dark mode.
    static func card(
        for colorScheme: ColorScheme
    ) -> Self {
        colorScheme == .light ? .white : .black
    }
}
