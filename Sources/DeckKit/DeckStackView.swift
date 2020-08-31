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
 */
public struct DeckStackView<CardType: Card>: View {
    
    /// Creates an instance of the view.
    ///
    /// - Parameters:
    ///   - deck: The generic deck that is to be presented.
    ///   - direction: Whether the deck goes `.up` or `.down`
    ///   - displayCount: The max number of cards to display.
    ///   - scaleOffset: The percentual shrink of each card.
    ///   - scaleOffset: The point-based offset of each card.
    ///   - viewBuilder: A builder that generates card views.
    public init(
        deck: Deck<CardType>,
        direction: Direction = .up,
        displayCount: Int = 10,
        scaleOffset: CGFloat = 0.02,
        verticalOffset: CGFloat = 10,
        viewBuilder: @escaping CardViewBuilder) {
        assert(scaleOffset > 0, "saleOffset must be positive")
        assert(verticalOffset > 0, "verticalOffset must be positive")
        self.context = DeckContext(deck: deck)
        self.direction = direction
        self.displayCount = displayCount
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
    
    private let direction: Direction
    private let displayCount: Int
    private let scaleOffset: CGFloat
    private let verticalOffset: CGFloat
    private let cardBuilder: (CardType) -> AnyView
    
    private var deck: Deck<CardType> { context.deck }
    private var cards: [CardType] { deck.cards }
    
    @ObservedObject private var context: DeckContext<CardType>
    @State private var activeCard: CardType? = nil
    @State private var topCardOffset: CGSize = .zero
    
    public var body: some View {
        ZStack(alignment: .center) {
            ForEach(cards.prefix(displayCount)) { card in
                cardBuilder(card)
                    .zIndex(zIndex(of: card))
                    .shadow(radius: 2)
                    .offset(size: dragOffset(for: card))
                    .offset(y: offset(of: card))
                    .scaleEffect(scale(of: card))
                    .rotationEffect(dragRotation(for: card))
                    .gesture(dragGesture(for: card))
            }
        }
    }
}

private extension View {
    
    func offset(size: CGSize) -> some View {
        offset(x: size.width, y: size.height)
    }
    
    func scaleEffect(_ all: CGFloat) -> some View {
        scaleEffect(x: all, y: all)
    }
}

public extension DeckStackView {
    
    func dragGesture(for card: CardType) -> some Gesture {
        DragGesture()
            .onChanged({ handleDragGestureChanged($0, for: card) })
            .onEnded({ handleDragGestureEnded($0, for: card) })
    }
    
    func handleDragGestureChanged(_ drag: DragGesture.Value, for card: CardType) {
        if activeCard == nil { activeCard = card }
        if card != activeCard { return }
        withAnimation(.spring()) {
            if drag.translation.width < -200 ||
                drag.translation.width > 200 ||
                drag.translation.height < -250 ||
                drag.translation.height > 250 {
                context.deck.moveToBack(card)
            } else {
                context.deck.moveToFront(card)
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
    
    func scale(of card: CardType) -> CGFloat {
        let index = deck.index(of: card)
        let offset = CGFloat(index) * scaleOffset
        return CGFloat(1 - offset)
    }
    
    func offset(of card: CardType) -> CGFloat {
        let index = deck.index(of: card)
        let offset = CGFloat(index) * verticalOffset
        let multiplier: CGFloat = direction == .down ? 1 : -1
        return offset * multiplier
    }
    
    func dragOffset(for card: CardType) -> CGSize {
        if card != activeCard { return .zero }
        return topCardOffset
    }
    
    func dragRotation(for card: CardType) -> Angle {
        if card != activeCard { return .degrees(0) }
        return .degrees(Double(topCardOffset.width) / 20.0)
    }
    
    func zIndex(of card: CardType) -> Double {
        Double(deck.cards.count - deck.index(of: card))
    }
}

struct DeckStackView_Previews: PreviewProvider {
    
    static var card: StandardBasicCard { StandardBasicCard(
        title: "Title",
        text: "Text",
        footnote: "Footnote",
        backgroundColor: .red,
        tintColor: .yellow)
    }
    
    static var deck = Deck(
        name: "My Deck",
        cards: [card, card, card, card, card, card, card])
    
    static var previews: some View {
        ZStack {
            Color.secondary
            DeckStackView(
                deck: deck,
                direction: .up,
                viewBuilder: { AnyView(BasicCardView(card: $0)) })
        }.edgesIgnoringSafeArea(.all)
    }
}
