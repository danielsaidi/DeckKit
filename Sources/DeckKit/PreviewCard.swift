//
//  PreviewCard.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import CoreGraphics

struct PreviewCard: View {
    
    init(
        item: Item,
        cornerRadius: CGFloat = 10
    ) {
        self.item = item
        self.cornerRadius = cornerRadius
    }

    struct Item: Identifiable {

        init(
            id: Int,
            title: String,
            text: String,
            footnote: String,
            backgroundColor: Color,
            tintColor: Color
        ) {
            self.id = id
            self.title = title
            self.text = text
            self.footnote = footnote
            self.backgroundColor = backgroundColor
            self.tintColor = tintColor
        }

        let id: Int
        let title: String
        let text: String
        let footnote: String

        let backgroundColor: Color
        let tintColor: Color
        
        var isEven: Bool {
            id.isMultiple(of: 2)
        }
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
        .background(Color.white)
        .cornerRadius(cornerRadius)
        .aspectRatio(0.65, contentMode: .fit)
    }
}

extension PreviewCard {
    
    var title: some View {
        Text(item.title)
            .font(.largeTitle)
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

#Preview {
    
    PreviewCard(
        item: PreviewCard.Item(
            id: 0,
            title: "Title",
            text: "Text",
            footnote: "Footnote",
            backgroundColor: .red,
            tintColor: .yellow
        )
    )
    .padding()
}
