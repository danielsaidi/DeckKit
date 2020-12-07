//
//  HobbyCard.swift
//  DeckKitDemo
//
//  Created by Daniel Saidi on 2020-09-22.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct HobbyCard: View {
    
    init(
        item: Hobby,
        size: CGSize = CGSize(width: 300, height: 400),
        cornerRadius: CGFloat = 10) {
        self.item = item
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    private let item: Hobby
    private let size: CGSize
    private let cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            VStack {
                title
                Divider()
                Spacer()
                image
                text
                Spacer()
                Divider()
                footnote
            }
        }
        .padding()
        .frame(width: size.width, height: size.height)
        .foregroundColor(item.foregroundColor)
        .background(item.backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

extension HobbyCard {
    
    var title: some View {
        Text(item.name).font(.title)
    }
    
    var image: some View {
        item.image
            .font(.title)
            .padding()
    }
    
    var text: some View {
        Text(item.text)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    var footnote: some View {
        Text("Swipe for a new hobby")
            .font(.footnote)
            .padding()
    }
}

struct HobbyCard_Previews: PreviewProvider {
    static var previews: some View {
        let item = Hobby.demoCollection[0]
        return HobbyCard(item: item)
    }
}
