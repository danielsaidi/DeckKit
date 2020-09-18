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
 This is a card view that presents a `BasicCardItem`. It can
 be used as is or as a template for creating your own custom
 card views.
 */
public struct BasicCard: View {
    
    public init(
        item: BasicItem,
        size: CGSize = CGSize(width: 300, height: 400),
        cornerRadius: CGFloat = 10) {
        self.item = item
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    private let item: BasicItem
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
        let item = BasicItem(
            title: "Title",
            text: "Text",
            footnote: "Footnote",
            backgroundColor: .red,
            tintColor: .yellow)
        return BasicCard(item: item)
    }
}
