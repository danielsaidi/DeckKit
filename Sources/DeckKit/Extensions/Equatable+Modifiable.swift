//
//  Equatable+Modified.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-02-19.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Equatable {

    /// Modify this value with a certain modification.
    func modified(with modification: (inout Self) -> Void) -> Self {
        var copy = self
        modification(&copy)
        return copy
    }
}
