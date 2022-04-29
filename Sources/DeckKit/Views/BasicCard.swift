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
        size: CGSize = CGSize(width: 300, height: 400),
        cornerRadius: CGFloat = 10) {
        self.item = item
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    private let item: Item
    private let size: CGSize
    private let cornerRadius: CGFloat
    
    public var body: some View {
        VStack {
            VStack {
                title
                Divider()
                text
                Spacer()
                Divider()
                footnote
            }
        }
        .padding()
        .frame(width: size.width, height: size.height)
        .foregroundColor(item.tintColor)
        .background(item.backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

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

struct BasicCard_Previews: PreviewProvider {
    static var previews: some View {
        let item = BasicCard.Item(
            title: "Title",
            text: "Text",
            footnote: "Footnote",
            backgroundColor: .red,
            tintColor: .yellow)
        return BasicCard(item: item)
    }
}
