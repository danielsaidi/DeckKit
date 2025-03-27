//
//  DeckPageView.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-12-31.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/// This view renders a collection of ``DeckItem`` values as
/// a horizontal page view.
public struct DeckPageView<ItemType: Identifiable, ItemView: View>: View {

    /// Create a deck page view.
    ///
    /// - Parameters:
    ///   - items: The items to present in the page view.
    ///   - itemView: An item view builder to use for each item.
    public init(
        _ items: Binding<[ItemType]>,
        itemView: @escaping ItemViewBuilder
    ) {
        self._items = items
        self.itemView = itemView
    }
    
    /// A function that creates a view for a deck item.
    public typealias ItemViewBuilder = (ItemType) -> ItemView
    
    @Binding
    private var items: [ItemType]
    
    private let itemView: (ItemType) -> ItemView

    public var body: some View {
        TabView {
            ForEach(items) {
                itemView($0)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    
    var item1: PreviewCard.Item { PreviewCard.Item(
        title: "Title 1",
        text: "Text 1",
        footnote: "Footnote 1",
        backgroundColor: .blue,
        tintColor: .yellow)
    }

    var item2: PreviewCard.Item { PreviewCard.Item(
        title: "Title 2",
        text: "Text 2",
        footnote: "Footnote 2",
        backgroundColor: .yellow,
        tintColor: .blue)
    }

    @State
    var items = [
        item1, item2, item1, item2, item1, item2,
        item1, item2, item1, item2, item1, item2,
        item1, item2, item1, item2, item1, item2,
        item1, item2, item1, item2, item1, item2
    ]

    return DeckPageView($items) {
        PreviewCard(item: $0)
            .aspectRatio(0.75, contentMode: .fit)
            .padding(15)
    }.background(Color.gray)
}
#endif
