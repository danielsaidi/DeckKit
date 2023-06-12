//
//  PreviewCard.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import CoreGraphics

/**
 This view can be used to presents a ``PreviewCard/Item``, and
 can be used as is or as a template for other cards.
 */
struct PreviewCard: View {
    
    /**
     Create a basic card.
     
     - Parameters:
       - item: The item to display in the card.
       - size: The size of the card.
       - cornerRadius: The corner radius of the card.
     */
    init(
        item: Item,
        cornerRadius: CGFloat = 10) {
        self.item = item
        self.cornerRadius = cornerRadius
    }

    struct Item: DeckItem {

        init(
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

        let id = UUID()

        let title: String
        let text: String
        let footnote: String

        let backgroundColor: Color
        let tintColor: Color
    }
    
    private let item: Item
    private let cornerRadius: CGFloat
    
    var body: some View {
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

extension PreviewCard {
    
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

struct PreviewCard_Previews: PreviewProvider {
    static var previews: some View {
        PreviewCard(
            item: PreviewCard.Item(
                title: "Title",
                text: "Text",
                footnote: "Footnote",
                backgroundColor: .red,
                tintColor: .yellow
            )
        ).padding()
    }
}
