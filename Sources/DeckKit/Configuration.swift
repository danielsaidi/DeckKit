//
//  Configuration.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-02-19.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import Foundation

/// This protocol can be implemented by config types, to get
/// access to a configuration mutating extension.
public protocol Configuration {}

public extension Configuration {
    
    /// Modify this configuration with a configuration block.
    func modified(_ modification: (inout Self) -> Void) -> Self {
        var copy = self
        modification(&copy)
        return copy
    }
}
