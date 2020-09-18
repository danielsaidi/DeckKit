//
//  BasicItem.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This is a basic implementation of the `CardItem` protocol.
 */
public struct BasicItem: CardItem {
    
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
