public struct CountingSet<U: Hashable>: Equatable, Collection {
    private var counts: [U : Double] = [:]

    public var isEmpty: Bool { return counts.isEmpty }

    public var count: Double { return counts.reduce(0, { $0 + $1.1 })}
    
    public mutating func increment(_ item: U, by inc: Double = 1) {
        counts[item] = (counts[item] ?? 0) + inc
    }

    public mutating func decrement(_ item: U, by dec: Double = 1) {
        let result = counts[item]! - dec
        if result <= 0 { counts[item] = nil } // makes empty check simpler
        else { counts[item] = result }
    }

    public mutating func add(_ other: CountingSet<U>) {
        for (k, v) in other.counts {
            counts[k] = (counts[k] ?? 0) + v
        }
    }

    // - MARK: Collection
    public func makeIterator() -> Dictionary<U, Double>.Iterator {
        return counts.makeIterator()
    }

    public typealias Index = Dictionary<U, Double>.Index
    public typealias SubSequence = Dictionary<U, Double>.SubSequence
    public typealias Indices = Dictionary<U, Double>.Indices

    public var startIndex: Index { return counts.startIndex }

    public var endIndex: Index { return counts.endIndex }

    public var indices: Indices { return counts.indices }
    
    public func index(after i: Index) -> Index {
        return counts.index(after: i)
    }

    public func contains(_ item: U) -> Bool {
        return counts[item] != nil
    }
    
    public subscript(item: Index) -> DictionaryIterator<U, Double>.Element {
        get { return counts[item] }
    }

    public subscript(item: Range<Index>) -> SubSequence {
        get { return counts[item] }
    }
    
    public subscript(item: U) -> Double {
        get { return counts[item] ?? 0 }
        set {
            if newValue > 0 { counts[item] = newValue }
            else { counts[item] = nil }
        }
    }

    init() { }

    public static func ==(lhs: CountingSet<U>, rhs: CountingSet<U>) -> Bool {
        return lhs.counts == rhs.counts
    }
}
