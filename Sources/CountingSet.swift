public struct CountingSet<U: Hashable>: Equatable, Collection {
    private var counts: [U : Int] = [:]

    public var isEmpty: Bool { return counts.isEmpty }

    public var count: Int { return counts.reduce(0, { $0 + $1.1 })}
    
    public mutating func increment(_ item: U) {
        counts[item] = (counts[item] ?? 0) + 1
    }

    public mutating func decrement(_ item: U) {
        let result = counts[item]! - 1
        if result == 0 { counts[item] = nil } // makes empty check simpler
        else { counts[item] = result }
    }

    public mutating func add(_ other: CountingSet<U>) {
        for (k, v) in other.counts {
            counts[k] = (counts[k] ?? 0) + v
        }
    }

    // - MARK: Collection
    public func makeIterator() -> Dictionary<U, Int>.Iterator {
        return counts.makeIterator()
    }

    public typealias Index = Dictionary<U, Int>.Index
    public typealias SubSequence = Dictionary<U, Int>.SubSequence
    public typealias Indices = Dictionary<U, Int>.Indices

    public var startIndex: Index { return counts.startIndex }

    public var endIndex: Index { return counts.endIndex }

    public var indices: Indices { return counts.indices }
    
    public func index(after i: Index) -> Index {
        return counts.index(after: i)
    }

    public func contains(_ item: U) -> Bool {
        return counts[item] != nil
    }
    
    public subscript(item: Index) -> DictionaryIterator<U, Int>.Element {
        get { return counts[item] }
    }

    public subscript(item: Range<Index>) -> SubSequence {
        get { return counts[item] }
    }
    
    public subscript(item: U) -> Int {
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
