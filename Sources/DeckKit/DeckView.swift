//
//  DeckView.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import SwiftUI

/**
 This view renders a ``Deck`` as deck of cards, from which a
 user can swipe away the top card to trigger certain actions.

 This view takes a generic ``Deck`` and a `cardBuilder` that
 maps deck items to card views. You can also configure it by
 passing in a ``DeckViewConfiguration`` that defines how the
 view should present the stack.
 */
public struct DeckView<ItemType: DeckItem, ItemView: View>: View {
    
    /**
     Creates an instance of the view.
     
     - Parameters:
       - deck: The generic deck that is to be presented.
       - config: The stacked deck configuration, by default ``DeckViewConfiguration/standard``.
       - swipeLeftAction: The action to trigger when a card is sent to the back of the deck by swiping it left, by default `nil`.
       - swipeRightAction: The action to trigger when a card is sent to the back of the deck by swiping it right, by default `nil`.
       - swipeUpAction: The action to trigger when a card is sent to the back of the deck by swiping it up, by default `nil`.
       - swipeDownAction: The action to trigger when a card is sent to the back of the deck by swiping it down, by default `nil`.
       - itemViewBuilder: A builder that generates a view for each item in the deck.
     */
    public init(
        deck: Binding<Deck<ItemType>>,
        config: DeckViewConfiguration,
        swipeLeftAction: ItemAction? = nil,
        swipeRightAction: ItemAction? = nil,
        swipeUpAction: ItemAction? = nil,
        swipeDownAction: ItemAction? = nil,
        itemViewBuilder: @escaping ItemViewBuilder
    ) {
        self.deck = deck
        self.config = config
        self.swipeLeftAction = swipeLeftAction
        self.swipeRightAction = swipeRightAction
        self.swipeUpAction = swipeUpAction
        self.swipeDownAction = swipeDownAction
        self.itemViewBuilder = itemViewBuilder
    }
    
    /**
     A function to trigger for a deck item swipe action.
     */
    public typealias ItemAction = (ItemType) -> Void

    /**
     A function that creates a view for a deck item.
     */
    public typealias ItemViewBuilder = (ItemType) -> ItemView
    
    private var deck: Binding<Deck<ItemType>>
    private var config: DeckViewConfiguration

    private let itemViewBuilder: (ItemType) -> ItemView
    private let swipeLeftAction: ItemAction?
    private let swipeRightAction: ItemAction?
    private let swipeUpAction: ItemAction?
    private let swipeDownAction: ItemAction?
    
    @State
    private var activeItem: ItemType?

    @State
    private var topCardOffset: CGSize = .zero
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(visibleItems, content: itemViewBuilderWithModifiers)
        }
    }
}


// MARK: - Properties

private extension DeckView {

    var items: [ItemType] {
        deck.wrappedValue.items
    }

    var visibleItems: [ItemType] {
        let first = Array(items.prefix(config.cardDisplayCount))
        guard
            config.alwaysShowLastCard,
            let last = items.last,
            !first.contains(last)
        else { return first }
        return Array(first) + [last]
    }
}


// MARK: - Functions

private extension DeckView {

    /**
     Move a certain item to the back of the stack.
     */
    func moveItemToBack(_ item: ItemType) {
        deck.wrappedValue.moveToBack(item)
    }

    /**
     Move a certain item to the front of the stack.
     */
    func moveItemToFront(_ item: ItemType) {
        deck.wrappedValue.moveToFront(item)
    }
}


// MARK: - View Logic

private extension DeckView {
    
    func itemViewBuilderWithModifiers(_ item: ItemType) -> some View {
        itemViewBuilder(item)
            .zIndex(zIndex(of: item))
            .shadow(radius: 0.5)
            .offset(size: dragOffset(for: item))
            .scaleEffect(scale(of: item))
            .offset(y: offset(of: item))
            .rotationEffect(dragRotation(for: item))
            .gesture(dragGesture(for: item))
    }
    
    func dragGesture(for item: ItemType) -> some Gesture {
        DragGesture()
            .onChanged { dragGestureChanged($0, for: item) }
            .onEnded { dragGestureEnded($0) }
    }
    
    func dragGestureChanged(_ drag: DragGesture.Value, for item: ItemType) {
        if activeItem == nil { activeItem = item }
        if item != activeItem { return }
        topCardOffset = drag.translation
        withAnimation(.spring()) {
            if dragGestureIsPastThreshold(drag) {
                moveItemToBack(item)
            } else {
                moveItemToFront(item)
            }
        }
    }
    
    func dragGestureEnded(_ drag: DragGesture.Value) {
        if let item = activeItem {
            (dragGestureEndedAction(for: drag))?(item)
        }
        withAnimation(.spring()) {
            activeItem = nil
            topCardOffset = .zero
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
        isActive(item) ? topCardOffset : .zero
    }
    
    func dragRotation(for item: ItemType) -> Angle {
        .degrees(isActive(item) ? Double(topCardOffset.width) * config.dragRotationFactor : 0)
    }
    
    func isActive(_ item: ItemType) -> Bool {
        item == activeItem
    }
    
    func offset(of item: ItemType) -> CGFloat {
        guard let index = visibleIndex(of: item) else { return .zero }
        let offset = CGFloat(index) * config.verticalOffset
        let multiplier: CGFloat = config.direction == .down ? 1 : -1
        return offset * multiplier
    }
    
    func scale(of item: ItemType) -> CGFloat {
        guard let index = visibleIndex(of: item) else { return 1 }
        let offset = CGFloat(index) * config.scaleOffset
        return CGFloat(1 - offset)
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

struct DeckView_Previews: PreviewProvider {

    struct Preview: View {

        static var item1: PreviewCard.Item { PreviewCard.Item(
            title: "Title 1",
            text: "Text 1",
            footnote: "Footnote 1",
            backgroundColor: .red,
            tintColor: .yellow)
        }

        static var item2: PreviewCard.Item { PreviewCard.Item(
            title: "Title 2",
            text: "Text 2",
            footnote: "Footnote 2",
            backgroundColor: .yellow,
            tintColor: .red)
        }

        @State
        private var deck = Deck(
            name: "My Deck",
            items: [item1, item2, item1, item2, item1, item2, item1, item2, item1, item2, item1, item2]
        )

        var body: some View {
            DeckView(
                deck: $deck,
                config: .init(direction: .down),
                itemViewBuilder: { PreviewCard(item: $0) }
            )
            .frame(maxHeight: .infinity)
            .padding(100)
            .background(background.edgesIgnoringSafeArea(.all))
        }

        var background: some View {
            Color.secondary.edgesIgnoringSafeArea(.all)
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
