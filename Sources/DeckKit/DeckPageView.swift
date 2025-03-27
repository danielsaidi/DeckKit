//
//  DeckPageView.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2024-12-31.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

/// This view renders a list of items as horizontal pages.
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
    
    struct Preview: View {
        
        @State
        var items: [PreviewCard.Item] = [
            .item1, .item2, .item1, .item2, .item1, .item2
        ]
        
        var body: some View {
            DeckPageView($items) {
                PreviewCard(item: $0)
                    .aspectRatio(0.75, contentMode: .fit)
                    .padding(15)
            }
        }
    }

    return Preview()
        .background(Color.gray)
}

private extension PreviewCard.Item {
    
    static var item1: Self { .init(
        title: "Title 1",
        text: "Text 1",
        footnote: "Footnote 1",
        backgroundColor: .blue,
        tintColor: .yellow)
    }

    static var item2: Self { .init(
        title: "Title 2",
        text: "Text 2",
        footnote: "Footnote 2",
        backgroundColor: .yellow,
        tintColor: .blue)
    }
}
#endif
