//
//  BasicCard.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI
import CoreGraphics

/**
 This view can be used to presents a ``BasicCard/Item``, and
 can be used as is or as a template for other cards.
 */
@available(*, deprecated, message: "BasicCard is deprecated and will be removed in DeckKit 0.6")
public struct BasicCard: View {
    
    /**
     Create a basic card.
     
     - Parameters:
       - item: The item to display in the card.
       - size: The size of the card.
       - cornerRadius: The corner radius of the card.
     */
    public init(
        item: Item,
        cornerRadius: CGFloat = 10) {
        self.item = item
        self.cornerRadius = cornerRadius
    }
    
    private let item: Item
    private let cornerRadius: CGFloat
    
    public var body: some View {
        VStack {
            VStack {
                title
                Divider()
                Spacer()
                text
                Spacer()
                Divider()
                footnote
            }
        }
        .padding()
        .foregroundColor(item.tintColor)
        .background(item.backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

@available(*, deprecated, message: "BasicCard is deprecated and will be removed in DeckKit 0.6")
public extension BasicCard {

    struct Item: DeckItem {

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
}

@available(*, deprecated, message: "BasicCard is deprecated and will be removed in DeckKit 0.6")
extension BasicCard {
    
    var title: some View {
        Text(item.title).font(.title)
    }
    
    var text: some View {
        Text(item.text)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var footnote: some View {
        Text(item.footnote)
            .font(.footnote)
            .padding()
    }
}

@available(*, deprecated, message: "BasicCard is deprecated and will be removed in DeckKit 0.6")
struct BasicCard_Previews: PreviewProvider {

    static var previews: some View {
        BasicCard(
            item: BasicCard.Item(
                title: "Title",
                text: "Text",
                footnote: "Footnote",
                backgroundColor: .red,
                tintColor: .yellow
            )
        ).padding()
    }
}
