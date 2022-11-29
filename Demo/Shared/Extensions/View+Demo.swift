//
//  View+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2022-11-29.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension View {

    func withDemoShadow() -> some View {
        self.shadow(radius: 0.3, x: 0, y: 1)
    }
}
