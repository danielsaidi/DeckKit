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
 This is a basic card view, that can be used either as is or
 as a template for creating your own card types.
 */
public struct BasicCardView<CardType: BasicCard>: View {
    
    public init(
        card: CardType,
        size: CGSize = CGSize(width: 300, height: 400),
        cornerRadius: CGFloat = 10) {
        self.card = card
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    private let card: CardType
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
        .foregroundColor(card.tintColor)
        .background(card.backgroundColor)
        .cornerRadius(cornerRadius)
        
    }
}

extension BasicCardView {
    
    var title: some View {
        Text(card.title).font(.title)
    }
    
    var text: some View {
        Text(card.text)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var footnote: some View {
        Text(card.footnote)
            .font(.footnote)
            .padding()
    }
}


struct BasicCard_Previews: PreviewProvider {
    static var previews: some View {
        let card = StandardBasicCard(
            title: "Title",
            text: "Text",
            footnote: "Footnote",
            backgroundColor: .red,
            tintColor: .yellow)
        return BasicCardView(card: card)
    }
}
