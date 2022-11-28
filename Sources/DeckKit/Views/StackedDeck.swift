//
//  StackedDeck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import SwiftUI

/**
 This view presents a deck of cards, from which the user can
 swipe away the top card to send it to the back of the stack.

 This view takes a generic ``Deck`` and a `cardBuilder` that
 maps deck items to card views.
 
 If there are more cards in the deck than are covered by the
 `displayCount` value, the `alwaysShowLastCard` parameter is
 used to determine if a card fades out when it is swiped off
 the top of the deck. If `alwaysShowLastCard` is `true`, the
 bottommost card is displayed together with the topmost ones.
 This will make the deck appear smaller than it is, but is a
 good way to be able to render a deck with many cards, while
 still making it performant and visually manageable.
 
 `ACKNOWLEDGEMENT` This view builds upon the amazing work by
 Alex Brown and his amazing card tutorial at:
 
 https://www.swiftcompiled.com/swiftui-cards/
 */
public struct StackedDeck<ItemType: DeckItem>: View {
    
    /**
     Creates an instance of the view.
     
     - Parameters:
       - deck: The generic deck that is to be presented.
       - config: The stacked deck configuration, by default ``StackedDeckConfiguration/standard``.
       - swipeLeftAction: The action to trigger when a card is sent to the back of the deck by swiping it left, by default `empty`.
       - swipeRightAction: The action to trigger when a card is sent to the back of the deck by swiping it right, by default `empty`.
       - swipeUpAction: The action to trigger when a card is sent to the back of the deck by swiping it up, by default `empty`.
       - swipeDownAction: The action to trigger when a card is sent to the back of the deck by swiping it down, by default `empty`.
       - cardBuilder: A builder that generates a card view for each item in the deck.
     */
    public init(
        deck: Binding<Deck<ItemType>>,
        config: StackedDeckConfiguration,
        swipeLeftAction: @escaping GestureAction = { _ in },
        swipeRightAction: @escaping GestureAction = { _ in },
        swipeUpAction: @escaping GestureAction = { _ in },
        swipeDownAction: @escaping GestureAction = { _ in },
        cardBuilder: @escaping CardBuilder
    ) {
        self.deck = deck
        self.config = config
        self.swipeLeftAction = swipeLeftAction
        self.swipeRightAction = swipeRightAction
        self.swipeUpAction = swipeUpAction
        self.swipeDownAction = swipeDownAction
        self.cardBuilder = cardBuilder
    }
    
    /**
     A function that takes an item and returns a card view.
     */
    public typealias CardBuilder = (ItemType) -> AnyView
    
    /**
     A function that is called when gestures causes a change
     for a certain item.
     */
    public typealias GestureAction = (ItemType) -> Void
    
    private var deck: Binding<Deck<ItemType>>
    private var config: StackedDeckConfiguration

    private let cardBuilder: (ItemType) -> AnyView
    private let swipeLeftAction: GestureAction
    private let swipeRightAction: GestureAction
    private let swipeUpAction: GestureAction
    private let swipeDownAction: GestureAction
    
    @State
    private var activeItem: ItemType?

    @State
    private var topCardOffset: CGSize = .zero
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(visibleItems, content: cardBuilderWithModifiers)
        }
    }
}


// MARK: - Properties

private extension StackedDeck {

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

private extension StackedDeck {

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

private extension StackedDeck {
    
    func cardBuilderWithModifiers(_ item: ItemType) -> some View {
        cardBuilder(item)
            .zIndex(zIndex(of: item))
            .shadow(radius: 2)
            .offset(size: dragOffset(for: item))
            .scaleEffect(scale(of: item))
            .offset(y: offset(of: item))
            .rotationEffect(dragRotation(for: item))
            .gesture(dragGesture(for: item))
    }
    
    func dragGesture(for item: ItemType) -> some Gesture {
        DragGesture()
            .onChanged({ dragGestureChanged($0, for: item) })
            .onEnded({ dragGestureEnded($0) })
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
    
    func dragGestureEndedAction(for drag: DragGesture.Value) -> GestureAction? {
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

struct StackedDeck_Previews: PreviewProvider {

    struct Preview: View {

        static var item1: BasicCard.Item { BasicCard.Item(
            title: "Title 1",
            text: "Text 1",
            footnote: "Footnote 1",
            backgroundColor: .red,
            tintColor: .yellow)
        }

        static var item2: BasicCard.Item { BasicCard.Item(
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
            StackedDeck(
                deck: $deck,
                config: .init(direction: .down),
                cardBuilder: { AnyView(BasicCard(item: $0)) }
            )
            .frame(width: 400, height: 600, alignment: .center)
            .padding(100)
            .background(background)
        }

        var background: some View {
            Color.blue
                .opacity(0.3)
                .edgesIgnoringSafeArea(.all)
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
