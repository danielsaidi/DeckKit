//
//  StackedDeck.swift
//  DeckKit
//
//  Created by Daniel Saidi on 2020-08-31.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view presents a deck as a stack, from which a user can
 swipe away the top card to send it to the end of the deck.
 
 If the number of visible cards (10 by default) is less than
 the total number of cards, the topmost cards will fade away
 when they are swiped away.
 
 This view takes a generic `Deck` as init parameter, as well
 as and a `cardBuilder` that takes the same card type as the
 deck as input parameter and returns a view.
 
 `alwaysShowLastCard` sets whether or not to always show the
 last card, even if it is too far back in the deck given the
 provided `displayCount`. If `true`, the card will be pushed
 to the end of the visible stack and then disappear when the
 next card is swiped from the top. If `false`, the card will
 fade out. If your cards have individual appearances, e.g. a
 unique color, you may want to set this to `false`, since it
 will be pretty obvious that the back of the stack is just a
 visual trick.
 */
public struct StackedDeck<ItemType: CardItem>: View {
    
    /// Creates an instance of the view.
    ///
    /// - Parameters:
    ///   - deck: The generic deck that is to be presented.
    ///   - direction: Whether the deck goes `.up` or `.down`
    ///   - displayCount: The max number of cards to display.
    ///   - alwaysShowLastCard: Whether or not to show the last card.
    ///   - scaleOffset: The percentual shrink of each card.
    ///   - scaleOffset: The point-based offset of each card.
    ///   - cardBuilder: A builder that generates card views.
    public init(
        deck: Deck<ItemType>,
        direction: Direction = .up,
        displayCount: Int = 10,
        alwaysShowLastCard: Bool = true,
        scaleOffset: CGFloat = 0.02,
        verticalOffset: CGFloat = 10,
        cardBuilder: @escaping CardBuilder) {
        assert(scaleOffset > 0, "scaleOffset must be positive")
        assert(verticalOffset > 0, "verticalOffset must be positive")
        self.context = DeckContext(deck: deck)
        self.direction = direction
        self.displayCount = displayCount
        self.alwaysShowLastCard = alwaysShowLastCard
        self.scaleOffset = scaleOffset
        self.verticalOffset = verticalOffset
        self.cardBuilder = cardBuilder
    }
    
    /**
     A function that takes an item and returns a card view.
     */
    public typealias CardBuilder = (ItemType) -> AnyView
    
    /**
     The offset direction of cards further down in the stack.
     */
    public enum Direction {
        case up, down
    }
    
    private let alwaysShowLastCard: Bool
    private let cardBuilder: (ItemType) -> AnyView
    private var deck: Deck<ItemType> { context.deck }
    private let direction: Direction
    private let displayCount: Int
    private var items: [ItemType] { deck.items }
    private let scaleOffset: CGFloat
    private let verticalOffset: CGFloat
    
    @ObservedObject private var context: DeckContext<ItemType>
    @State private var activeItem: ItemType?
    @State private var topCardOffset: CGSize = .zero
    @State private var visibleItems: [ItemType] = []
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(visibleItems, content: cardBuilderWithModifiers)
        }.onAppear(perform: refreshCards)
    }
}


// MARK: - Functions

public extension StackedDeck {
    
    func moveItemToBack(_ item: ItemType) {
        context.deck.moveToBack(item)
        refreshCards()
    }
    
    func moveItemToFront(_ item: ItemType) {
        context.deck.moveToFront(item)
        refreshCards()
    }
    
    func refreshCards() {
        let first = Array(items.prefix(displayCount))
        guard
            alwaysShowLastCard,
            let last = items.last,
            !first.contains(last)
        else { return visibleItems = first }
        visibleItems = Array(first) + [last]
    }
}


// MARK: - View Logic

public extension StackedDeck {
    
    func cardBuilderWithModifiers(_ item: ItemType) -> some View {
        cardBuilder(item)
            .zIndex(zIndex(of: item))
            .shadow(radius: 2)
            .offset(size: dragOffset(for: item))
            .offset(y: offset(of: item))
            .scaleEffect(scale(of: item))
            .rotationEffect(dragRotation(for: item))
            .gesture(dragGesture(for: item))
    }
    
    func dragGesture(for item: ItemType) -> some Gesture {
        DragGesture()
            .onChanged({ handleDragGestureChanged($0, for: item) })
            .onEnded({ handleDragGestureEnded($0) })
    }
    
    func dragOffset(for item: ItemType) -> CGSize {
        if item != activeItem { return .zero }
        return topCardOffset
    }
    
    func dragRotation(for item: ItemType) -> Angle {
        if item != activeItem { return .degrees(0) }
        return .degrees(Double(topCardOffset.width) / 20.0)
    }
    
    func handleDragGestureChanged(_ drag: DragGesture.Value, for item: ItemType) {
        if activeItem == nil { activeItem = item }
        if item != activeItem { return }
        withAnimation(.spring()) {
            if drag.translation.width < -200 ||
                drag.translation.width > 200 ||
                drag.translation.height < -250 ||
                drag.translation.height > 250 {
                moveItemToBack(item)
            } else {
                moveItemToFront(item)
            }
            topCardOffset = drag.translation
        }
    }
    
    func handleDragGestureEnded(_ drag: DragGesture.Value) {
        withAnimation(.spring()) {
            activeItem = nil
            topCardOffset = .zero
        }
    }
    
    func offset(of item: ItemType) -> CGFloat {
        guard let index = visibleItems.firstIndex(of: item) else { return .zero }
        let offset = CGFloat(index) * verticalOffset
        let multiplier: CGFloat = direction == .down ? 1 : -1
        return offset * multiplier
    }
    
    func scale(of item: ItemType) -> CGFloat {
        guard let index = visibleItems.firstIndex(of: item) else { return 1 }
        let offset = CGFloat(index) * scaleOffset
        return CGFloat(1 - offset)
    }
    
    func zIndex(of card: ItemType) -> Double {
        guard let index = visibleItems.firstIndex(of: card) else { return 0 }
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
    
    static var item1: BasicItem { BasicItem(
        title: "Title 1",
        text: "Text 1",
        footnote: "Footnote 1",
        backgroundColor: .red,
        tintColor: .yellow)
    }
    
    static var item2: BasicItem { BasicItem(
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
            deck: deck,
            direction: .up,
            cardBuilder: { AnyView(BasicCard(item: $0)) })
            .frame(width: 400, height: 600, alignment: .center)
            .padding(100)
            .background(Color.secondary)
    }
}
