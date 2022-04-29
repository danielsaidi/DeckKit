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
 This view presents a deck as a stack, from which a user can
 swipe away the top card and send it to the back of the deck.

 This view takes a generic `Deck` as init parameter, as well
 as a `cardBuilder` function that uses the same item type as
 the deck as input parameter and returns a view.
 
 If there are more cards in the deck than are covered by the
 `displayCount` value, the `alwaysShowLastCard` parameter is
 used to determine if a card fades out when it is swiped off
 the top of the deck. If `alwaysShowLastCard` is `true`, the
 bottommost card is displayed together with the topmost ones.
 This will make the deck appear smaller than it is, but is a
 good way to be able to render a deck with many cards, while
 still making it performant and visually manageable.
 
 `ACKNOWLEDGEMENT` This view builds upon the amazing work by
 Alex Brown (@Alex_Brown23) and his amazing card tutorial at
 https://www.swiftcompiled.com/swiftui-cards/.manageable
 */
public struct StackedDeck<ItemType: DeckItem>: View {
    
    /// Creates an instance of the view.
    ///
    /// - Parameters:
    ///   - deck: The generic deck that is to be presented.
    ///   - direction: Whether the deck goes `.up` or `.down`
    ///   - displayCount: The max number of cards to display.
    ///   - alwaysShowLastCard: Whether or not to show the last card.
    ///   - scaleOffset: The percentual shrink of each card.
    ///   - verticalOffset: The point-based vertical offset of each card.
    ///   - swipeLeftAction: Called when a card sent to the back of the deck by swiping it left.
    ///   - swipeRightAction: Called when a card sent to the back of the deck by swiping it right.
    ///   - swipeUpAction: Called when a card sent to the back of the deck by swiping it up.
    ///   - swipeDownAction: Called when a card sent to the back of the deck by swiping it down.
    ///   - cardBuilder: A builder that generates card views.
    public init(
        deck: Binding<Deck<ItemType>>,
        direction: Direction = .up,
        displayCount: Int = 10,
        alwaysShowLastCard: Bool = true,
        scaleOffset: CGFloat = 0.02,
        verticalOffset: CGFloat = 10,
        swipeLeftAction: @escaping GestureAction = { _ in },
        swipeRightAction: @escaping GestureAction = { _ in },
        swipeUpAction: @escaping GestureAction = { _ in },
        swipeDownAction: @escaping GestureAction = { _ in },
        cardBuilder: @escaping CardBuilder) {
        assert(scaleOffset > 0, "scaleOffset must be positive")
        assert(verticalOffset > 0, "verticalOffset must be positive")
        self.deck = deck
        self.direction = direction
        self.displayCount = displayCount
        self.alwaysShowLastCard = alwaysShowLastCard
        self.scaleOffset = scaleOffset
        self.verticalOffset = verticalOffset
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
    
    /**
     The offset direction of cards further down in the stack.
     */
    public enum Direction {
        case up, down
    }
    
    private var deck: Binding<Deck<ItemType>>
    private var items: [ItemType] { deck.wrappedValue.items }
    
    private let alwaysShowLastCard: Bool
    private let cardBuilder: (ItemType) -> AnyView
    private let direction: Direction
    private let displayCount: Int
    private let scaleOffset: CGFloat
    private let swipeLeftAction: GestureAction
    private let swipeRightAction: GestureAction
    private let swipeUpAction: GestureAction
    private let swipeDownAction: GestureAction
    private let verticalOffset: CGFloat
    
    @State private var activeItem: ItemType?
    @State private var topCardOffset: CGSize = .zero
    
    private var visibleItems: [ItemType] {
        let first = Array(items.prefix(displayCount))
        guard
            alwaysShowLastCard,
            let last = items.last,
            !first.contains(last)
        else { return first }
        return Array(first) + [last]
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(visibleItems, content: cardBuilderWithModifiers)
        }
    }
}


// MARK: - Functions

public extension StackedDeck {
    
    func moveItemToBack(_ item: ItemType) {
        deck.wrappedValue.moveToBack(item)
    }
    
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
        withAnimation(.spring()) {
            if dragGestureIsPastThreshold(drag) {
                moveItemToBack(item)
            } else {
                moveItemToFront(item)
            }
            topCardOffset = drag.translation
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
        abs(drag.translation.width) > 200
    }
    
    func dragGestureIsPastVerticalThreshold(_ drag: DragGesture.Value) -> Bool {
        abs(drag.translation.height) > 250
    }
    
    func dragOffset(for item: ItemType) -> CGSize {
        isActive(item) ? topCardOffset : .zero
    }
    
    func dragRotation(for item: ItemType) -> Angle {
        .degrees(isActive(item) ? Double(topCardOffset.width) / 20.0 : 0)
    }
    
    func isActive(_ item: ItemType) -> Bool {
        item == activeItem
    }
    
    func offset(of item: ItemType) -> CGFloat {
        guard let index = visibleIndex(of: item) else { return .zero }
        let offset = CGFloat(index) * verticalOffset
        let multiplier: CGFloat = direction == .down ? 1 : -1
        return offset * multiplier
    }
    
    func scale(of item: ItemType) -> CGFloat {
        guard let index = visibleIndex(of: item) else { return 1 }
        let offset = CGFloat(index) * scaleOffset
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
    
    static var deck = Deck(
        name: "My Deck",
        items: [item1, item2, item1, item2, item1, item2, item1, item2, item1, item2, item1, item2])
    
    static var previews: some View {
        StackedDeck(
            deck: .constant(deck),
            direction: .up,
            cardBuilder: { AnyView(BasicCard(item: $0)) })
            .frame(width: 400, height: 600, alignment: .center)
            .padding(100)
            .background(Color.secondary)
    }
}

#endif
