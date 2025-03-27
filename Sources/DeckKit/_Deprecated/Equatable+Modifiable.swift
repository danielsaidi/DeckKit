@available(*, deprecated, message: "This is no longer used.")
public extension Equatable {

    /// Modify this value with a certain modification.
    func modified(with modification: (inout Self) -> Void) -> Self {
        var copy = self
        modification(&copy)
        return copy
    }
}
