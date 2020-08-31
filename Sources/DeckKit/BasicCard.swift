//
//  BasicCard.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by basc cards. You can use
 `StandardBasicCard` or create your own implementation.
 */
public protocol BasicCard: Card {
    
    var title: String { get }
    var text: String { get }
    var footnote: String { get }
    
    var backgroundColor: Color { get }
    var tintColor: Color { get }
}

/**
 This is a basic implementation of the `BasicCard` protocol.
 You can use it as is if you just want a plane basic card.
 */
public struct StandardBasicCard: BasicCard {
    
    public init(
        title: String,
        text: String,
        footnote: String,
        backgroundColor: Color,
        tintColor: Color) {
        self.title = title
        self.text = text
        self.footnote = footnote
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
    }
    
    public let id = UUID()

    public let title: String
    public let text: String
    public let footnote: String

    public let backgroundColor: Color
    public let tintColor: Color
}
