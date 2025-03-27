//
//  DeckView.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(visionOS)
import SwiftUI

/// This view renders a list of items as a deck of cards.
///
/// The view can swipe the top card in any direction to move
/// it to the bottom of the deck and trigger certain actions.
///
/// You can use the ``SwiftUI/View/deckViewConfiguration(_:)``
/// view modifier to apply a custom configuration.
public struct DeckView<ItemType: Identifiable, ItemView: View>: View {
    
    /// Create a deck view with custom parameters.
    ///
    /// - Parameters:
    ///   - items: The items to present.
    ///   - shuffleAnimation: The shuffle animation to use, by default a standard one.
    ///   - shuffleAnimation: The animation to apply when the state changes, by default `.bouncy`.
    ///   - swipeAction: The action to trigger when swiping items to an edge, by default `nil`.
    ///   - itemView: An item view builder to use for each item in the deck.
    public init(
        _ items: Binding<[ItemType]>,
        shuffleAnimation: DeckShuffleAnimation = .init(),
        stateAnimation: Animation = .bouncy,
        swipeAction: SwipeAction? = nil,
        itemView: @escaping ItemViewBuilder
    ) {
        self._items = items
        self.initConfig = nil
        self._shuffleAnimation = .init(wrappedValue: shuffleAnimation)
        self.stateAnimation = stateAnimation
        self.swipeAction = swipeAction
        self.itemView = itemView
    }
    
    /// An action to trigger by swiping items to either edge.
    public typealias SwipeAction = (Edge, ItemType) -> Void
    
    /// A function that creates a view for a deck item.
    public typealias ItemViewBuilder = (ItemType) -> ItemView
    
    var initConfig: DeckViewConfiguration?
    
    private let itemView: (ItemType) -> ItemView
    private let stateAnimation: Animation
    private let swipeAction: SwipeAction?
    
    @Binding var items: [ItemType]
    
    @Environment(\.deckViewConfiguration)
    var envConfig: DeckViewConfiguration
    
    @ObservedObject var shuffleAnimation: DeckShuffleAnimation
    
    @State var activeItem: ItemType?
    @State var topItemOffset: CGSize = .zero
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(visibleItems) { item in
                itemView(item)
                    .zIndex(zIndex(of: item))
                    .shadow(color: Color.black.opacity(0.1), radius: 0, y: 1)
                    .offset(size: dragOffset(for: item))
                    .scaleEffect(scale(of: item))
                    .offset(y: offset(of: item))
                    .rotationEffect(dragRotation(for: item) ?? .zero)
                    .gesture(dragGesture(for: item))
                    .deckShuffleAnimation(
                        shuffleAnimation,
                        for: item,
                        in: items
                    )
            }
        }
    }
}


// MARK: - Properties

private extension DeckView {
    
    var config: DeckViewConfiguration {
        initConfig ?? envConfig
    }
    
    var visibleItems: [ItemType] {
        let first = Array(items.prefix(config.itemDisplayCount))
        guard
            config.alwaysShowLastItem,
            let last = items.last,
            !first.contains(last)
        else { return first }
        return Array(first).dropLast() + [last]
    }
}


// MARK: - View Logic

private extension DeckView {
    
    func dragGesture(for item: ItemType) -> some Gesture {
        DragGesture()
            .onChanged { dragGestureChanged($0, for: item) }
            .onEnded { dragGestureEnded($0) }
    }
    
    func dragGestureChanged(_ drag: DragGesture.Value, for item: ItemType) {
        if activeItem == nil { activeItem = item }
        if !isActive(item) { return }
        topItemOffset = drag.translation
        withAnimation(stateAnimation) {
            if dragGestureIsPastThreshold(drag) {
                items.moveToBack(item)
            } else {
                items.moveToFront(item)
            }
        }
    }
    
    func dragGestureEnded(_ drag: DragGesture.Value) {
        if let item = activeItem, let edge = dragGestureEndedEdge(for: drag) {
            swipeAction?(edge, item)
        }
        withAnimation(stateAnimation) {
            activeItem = nil
            topItemOffset = .zero
        }
    }
    
    func dragGestureEndedEdge(for drag: DragGesture.Value) -> Edge? {
        guard dragGestureIsPastThreshold(drag) else { return nil }
        if dragGestureIsPastHorizontalThreshold(drag) {
            return drag.translation.width > 0 ? .trailing : .leading
        } else {
            return drag.translation.height > 0 ? .bottom : .top
        }
    }
    
    func dragGestureIsPastThreshold(_ drag: DragGesture.Value) -> Bool {
        dragGestureIsPastHorizontalThreshold(drag) || dragGestureIsPastVerticalThreshold(drag)
    }
    
    func dragGestureIsPastHorizontalThreshold(_ drag: DragGesture.Value) -> Bool {
        abs(drag.translation.width) > config.horizontalDragThreshold
    }
    
    func dragGestureIsPastVerticalThreshold(_ drag: DragGesture.Value) -> Bool {
        abs(drag.translation.height) > config.verticalDragThreshold
    }
    
    func dragOffset(for item: ItemType) -> CGSize {
        isActive(item) ? topItemOffset : .zero
    }
    
    func dragRotation(for item: ItemType) -> Angle? {
        guard isActive(item) else { return nil }
        return .degrees(Double(topItemOffset.width) * config.dragRotationFactor)
    }
    
    func isActive(_ item: ItemType) -> Bool {
        item.id == activeItem?.id
    }

    func offset(at index: Int) -> Double {
        if shuffleAnimation.isShuffling { return 0 }
        
        let offset = Double(index) * config.verticalOffset
        let multiplier: Double = config.direction == .down ? 1 : -1
        return offset * multiplier
    }
    
    func offset(of item: ItemType) -> Double {
        guard let index = visibleIndex(of: item) else { return .zero }
        return offset(at: index)
    }

    func scale(at index: Int) -> Double {
        let offset = Double(index) * config.scaleOffset
        return Double(1 - offset)
    }

    func scale(of item: ItemType) -> Double {
        guard let index = visibleIndex(of: item) else { return 1 }
        return scale(at: index)
    }

    func visibleIndex(of item: ItemType) -> Int? {
        visibleItems.index(of: item)
    }
    
    func zIndex(of index: ItemType) -> Double {
        guard let index = visibleIndex(of: index) else { return 0 }
        return Double(visibleItems.count - index)
    }
}


// MARK: - Private View Extensions

private extension View {
    
    func offset(size: CGSize) -> some View {
        offset(x: size.width, y: size.height)
    }
    
    func scaleEffect(_ all: CGFloat) -> some View {
        scaleEffect(x: all, y: all)
    }
}


// MARK: - Preview

private func item(
    _ index: Int
) -> PreviewCard.Item {
    .init(
        title: "Title \(index)",
        text: "Text \(index)",
        footnote: "Footnote \(index)",
        backgroundColor: .gray.opacity(0.1),
        tintColor: .black
    )
}

#Preview {
    
    @MainActor
    struct Preview: View {
        
        @State
        var shuffle = DeckShuffleAnimation(animation: .snappy)
        
        @State
        var items = (0...25).map {
            item($0)
        }
        
        var body: some View {
            VStack(spacing: 70) {
                DeckView(
                    $items,
                    shuffleAnimation: shuffle,
                    swipeAction: { edge, item in
                        print("Swiped item #\(item.id) to the \(edge.description) edge")
                    },
                    itemView: { item in
                        CardView(
                            isFlipped: shuffle.isShuffling,
                            front: { PreviewCard(item: item) },
                            back: { Color.blue }
                        )
                        .aspectRatio(0.65, contentMode: .fit)
                    }
                )

                Button("Shuffle") {
                    shuffle.shuffle($items)
                }
                #if os(visionOS)
                .background(Color.blue, in: .capsule)
                #else
                .buttonStyle(.borderedProminent)
                #endif
            }
            .padding()
            .deckViewConfiguration(.init(direction: .down))
        }
    }

    return Preview()
}

private extension Edge {
    
    var description: String {
        switch self {
        case .leading: "leading"
        case .trailing: "trailing"
        case .top: "top"
        case .bottom: "bottom"
        }
    }
}
#endif
