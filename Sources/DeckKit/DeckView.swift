//
//  DeckView.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS) || os(visionOS)
import SwiftUI

/**
 This view renders a ``Deck`` as a stack of cards from which
 users can swipe away the top item and trigger actions.

 The view takes a generic ``Deck`` and maps its items to any
 views, as determined by the `itemViewBuilder`. 
 
 You can pass in a custom ``DeckViewConfiguration`` with the
 `.deckViewConfiguration` view modifier.
 */
public struct DeckView<ItemType: DeckItem, ItemView: View>: View {
    
    /**
     Create a deck view with custom parameters.
     
     - Parameters:
       - items: The items to present.
       - config: The configuration to apply, by default `.standard`.
       - shuffleAnimation: The shuffle animation to apply, by default an internal one.
       - swipeLeftAction: The action to trigger when swiping items left, by default `nil`.
       - swipeRightAction: The action to trigger when swiping items right, by default `nil`.
       - swipeUpAction: The action to trigger when swiping items up, by default `nil`.
       - swipeDownAction: The action to trigger when swiping items down, by default `nil`.
       - itemView: An item view builder to use for each item in the deck.
     */
    public init(
        _ items: Binding<[ItemType]>,
        shuffleAnimation: DeckShuffleAnimation = .init(),
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        itemView: @escaping ItemViewBuilder
    ) {
        self._items = items
        self.initConfig = nil
        self._shuffleAnimation = .init(wrappedValue: shuffleAnimation)
        self.swipeLeftAction = swipeLeftAction
        self.swipeRightAction = swipeRightAction
        self.swipeUpAction = swipeUpAction
        self.swipeDownAction = swipeDownAction
        self.itemView = itemView
    }
    
    @available(*, deprecated, message: "Apply a configuration with the .deckViewConfiguration view modifier instead.")
    public init(
        _ items: Binding<[ItemType]>,
        config: DeckViewConfiguration,
        shuffleAnimation: DeckShuffleAnimation = .init(),
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        itemView: @escaping ItemViewBuilder
    ) {
        self._items = items
        self.initConfig = config
        self._shuffleAnimation = .init(wrappedValue: shuffleAnimation)
        self.swipeLeftAction = swipeLeftAction
        self.swipeRightAction = swipeRightAction
        self.swipeUpAction = swipeUpAction
        self.swipeDownAction = swipeDownAction
        self.itemView = itemView
    }
    
    /// A function to trigger when swiping away a deck item.
    public typealias ItemAction = (ItemType) -> Void

    /// A function that creates a view for a deck item.
    public typealias ItemViewBuilder = (ItemType) -> ItemView
    
    private var initConfig: DeckViewConfiguration?
    private let itemView: (ItemType) -> ItemView
    private let swipeLeftAction: ItemAction?
    private let swipeRightAction: ItemAction?
    private let swipeUpAction: ItemAction?
    private let swipeDownAction: ItemAction?
    
    @Binding
    private var items: [ItemType]
    
    @Environment(\.deckViewConfiguration)
    private var envConfig: DeckViewConfiguration
    
    @ObservedObject
    private var shuffleAnimation: DeckShuffleAnimation
    
    @State
    private var activeItem: ItemType?

    @State
    private var topItemOffset: CGSize = .zero
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(visibleItems) { item in
                itemView(item)
                    .zIndex(zIndex(of: item))
                    .shadow(radius: 0.5)
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
        if item != activeItem { return }
        topItemOffset = drag.translation
        withAnimation(.spring()) {
            if dragGestureIsPastThreshold(drag) {
                items.moveToBack(item)
            } else {
                items.moveToFront(item)
            }
        }
    }
    
    func dragGestureEnded(_ drag: DragGesture.Value) {
        if let item = activeItem {
            (dragGestureEndedAction(for: drag))?(item)
        }
        withAnimation(.spring()) {
            activeItem = nil
            topItemOffset = .zero
        }
    }
    
    func dragGestureEndedAction(for drag: DragGesture.Value) -> ItemAction? {
        guard dragGestureIsPastThreshold(drag) else { return nil }
        if dragGestureIsPastHorizontalThreshold(drag) {
            return drag.translation.width > 0 ? swipeRightAction : swipeLeftAction
        } else {
            return drag.translation.height > 0 ? swipeDownAction : swipeUpAction
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
        item == activeItem
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
        visibleItems.firstIndex(of: item)
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
        var items = (0...25).enumerated().map {
            item($0.offset)
        }
        
        var preview: some View {
            VStack(spacing: 70) {
                DeckView(
                    $items,
                    shuffleAnimation: shuffle,
                    swipeLeftAction: { _ in print("Left") },
                    swipeRightAction: { _ in print("Right") },
                    swipeUpAction: { _ in print("Up") },
                    swipeDownAction: { _ in print("Down") },
                    itemView: { PreviewCard(item: $0) }
                )
                #if os(visionOS)
                .aspectRatio(0.75, contentMode: .fit)
                #endif
                
                Button("Shuffle") {
                    shuffle.shuffle($items)
                }
                #if os(visionOS)
                .background(Color.blue, in: .capsule)
                #else
                .buttonStyle(.borderedProminent)
                #endif
            }
        }
        
        var body: some View {
            preview
                .padding()
                .padding(.vertical, 100)
        }
    }

    return Preview()
}
#endif
