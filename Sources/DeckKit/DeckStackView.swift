//
//  DeckStackView.swift
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
public struct DeckStackView<CardType: Card>: View {
    
    /// Creates an instance of the view.
    ///
    /// - Parameters:
    ///   - deck: The generic deck that is to be presented.
    ///   - direction: Whether the deck goes `.up` or `.down`
    ///   - displayCount: The max number of cards to display.
    ///   - alwaysShowLastCard: Whether or not to show the last card.
    ///   - scaleOffset: The percentual shrink of each card.
    ///   - scaleOffset: The point-based offset of each card.
    ///   - viewBuilder: A builder that generates card views.
    public init(
        deck: Deck<CardType>,
        direction: Direction = .up,
        displayCount: Int = 10,
        alwaysShowLastCard: Bool = true,
        scaleOffset: CGFloat = 0.02,
        verticalOffset: CGFloat = 10,
        viewBuilder: @escaping CardViewBuilder) {
        assert(scaleOffset > 0, "scaleOffset must be positive")
        assert(verticalOffset > 0, "verticalOffset must be positive")
        self.context = DeckContext(deck: deck)
        self.direction = direction
        self.displayCount = displayCount
        self.alwaysShowLastCard = alwaysShowLastCard
        self.scaleOffset = scaleOffset
        self.verticalOffset = verticalOffset
        self.cardBuilder = viewBuilder
    }
    
    /**
     A function that takes a card and returns a view.
     */
    public typealias CardViewBuilder = (CardType) -> AnyView
    
    /**
     The offset direction of cards further down in the stack.
     */
    public enum Direction {
        case up, down
    }
    
    private let alwaysShowLastCard: Bool
    private let cardBuilder: (CardType) -> AnyView
    private let direction: Direction
    private let displayCount: Int
    private let scaleOffset: CGFloat
    private let verticalOffset: CGFloat
    
    private var deck: Deck<CardType> { context.deck }
    private var cards: [CardType] { deck.cards }
    
    @State private var visibleCards: [CardType] = []
    
    @ObservedObject private var context: DeckContext<CardType>
    @State private var activeCard: CardType? = nil
    @State private var topCardOffset: CGSize = .zero
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(visibleCards, content: cardBuilderWithModifiers)
        }.onAppear(perform: refreshVisibleCards)
    }
}


// MARK: - Functions

public extension DeckStackView {
    
    func moveCardToBack(_ card: CardType) {
        context.deck.moveToBack(card)
        refreshVisibleCards()
    }
    
    func moveCardToFront(_ card: CardType) {
        context.deck.moveToFront(card)
        refreshVisibleCards()
    }
    
    func refreshVisibleCards() {
        let first = Array(cards.prefix(displayCount))
        guard
            alwaysShowLastCard,
            let last = cards.last,
            !first.contains(last)
            else { return visibleCards = first }
        visibleCards = Array(first) + [last]
    }
}


// MARK: - View Logic

public extension DeckStackView {
    
    func cardBuilderWithModifiers(_ card: CardType) -> some View {
        cardBuilder(card)
            .zIndex(zIndex(of: card))
            .shadow(radius: 2)
            .offset(size: dragOffset(for: card))
            .offset(y: offset(of: card))
            .scaleEffect(scale(of: card))
            .rotationEffect(dragRotation(for: card))
            .gesture(dragGesture(for: card))
    }
    
    func dragGesture(for card: CardType) -> some Gesture {
        DragGesture()
            .onChanged({ handleDragGestureChanged($0, for: card) })
            .onEnded({ handleDragGestureEnded($0, for: card) })
    }
    
    func dragOffset(for card: CardType) -> CGSize {
        if card != activeCard { return .zero }
        return topCardOffset
    }
    
    func dragRotation(for card: CardType) -> Angle {
        if card != activeCard { return .degrees(0) }
        return .degrees(Double(topCardOffset.width) / 20.0)
    }
    
    func handleDragGestureChanged(_ drag: DragGesture.Value, for card: CardType) {
        if activeCard == nil { activeCard = card }
        if card != activeCard { return }
        withAnimation(.spring()) {
            if drag.translation.width < -200 ||
                drag.translation.width > 200 ||
                drag.translation.height < -250 ||
                drag.translation.height > 250 {
                moveCardToBack(card)
            } else {
                moveCardToFront(card)
            }
            topCardOffset = drag.translation
        }
    }
    
    func handleDragGestureEnded(_ drag: DragGesture.Value, for card: CardType) {
        withAnimation(.spring()) {
            activeCard = nil
            topCardOffset = .zero
        }
    }
    
    func offset(of card: CardType) -> CGFloat {
        guard let index = visibleCards.firstIndex(of: card) else { return .zero }
        let offset = CGFloat(index) * verticalOffset
        let multiplier: CGFloat = direction == .down ? 1 : -1
        return offset * multiplier
    }
    
    func scale(of card: CardType) -> CGFloat {
        guard let index = visibleCards.firstIndex(of: card) else { return 1 }
        let offset = CGFloat(index) * scaleOffset
        return CGFloat(1 - offset)
    }
    
    func zIndex(of card: CardType) -> Double {
        guard let index = visibleCards.firstIndex(of: card) else { return 0 }
        return Double(deck.cards.count - index)
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

struct DeckStackView_Previews: PreviewProvider {
    
    @State static var isSheetPresented = false
    
    static var card1: StandardBasicCard { StandardBasicCard(
        title: "Title 1",
        text: "Text 1",
        footnote: "Footnote 1",
        backgroundColor: .red,
        tintColor: .yellow)
    }
    
    static var card2: StandardBasicCard { StandardBasicCard(
        title: "Title 2",
        text: "Text 2",
        footnote: "Footnote 2",
        backgroundColor: .yellow,
        tintColor: .red)
    }
    
    static var deck = Deck(
        name: "My Deck",
        cards: [card1, card2, card1, card2, card1, card2, card1, card2, card1, card2, card1, card2])
    
    static var previews: some View {
        VStack {
            DeckStackView(
                deck: deck,
                direction: .up,
                viewBuilder: { AnyView(BasicCardView(card: $0)) })
                .padding(100)
                .background(Color.secondary)
                .onTapGesture(perform: presentSheet)
                .sheet(isPresented: $isSheetPresented, content: {
                    Text("HEJ")
                })
            Button("Present Sheet", action: presentSheet)
        }
        
    }
    
    static func presentSheet() {
        isSheetPresented = true
    }
}
