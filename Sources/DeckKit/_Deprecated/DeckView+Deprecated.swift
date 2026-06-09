import Foundation

#if os(iOS) || os(macOS) || os(visionOS)
@available(*, deprecated, renamed: "Deck")
public typealias DeckView = Deck

@available(*, deprecated, renamed: "DeckConfiguration")
public typealias DeckViewConfiguration = DeckConfiguration
#endif
