import SwiftUI

@available(*, deprecated, message: "Just use Identifiable instead.")
public protocol DeckItem: Identifiable {}

@available(*, deprecated, renamed: "CardView")
public typealias Card = CardView

public extension Card {
    
    @available(*, deprecated, message: "This view no longer applies a corner radius. Add this to the front and back views instead.")
    init(
        isFlipped: Bool,
        cornerRadius: Double,
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back
    ) {
        self.init(isFlipped: isFlipped, front: front, back: back)
    }
}
