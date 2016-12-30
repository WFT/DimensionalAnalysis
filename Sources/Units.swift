public enum UnitAnalysis<Symbol: Hashable>: Equatable {
    public typealias UnitSeries = CountingSet<Symbol>
    case unitless
    case single(Symbol)
    case multiply(UnitSeries)
    case divide(numerator: UnitSeries,
                denominator: UnitSeries)
    
    public init(_ sym: Symbol) {
        self = .single(sym)
    }

    private var numerator: UnitSeries {
        switch self {
        case .unitless: return UnitSeries()
        case let .single(m):
            var num = UnitSeries()
            num.increment(m)
            return num
        case let .multiply(m):
            return m
        case let .divide(num, _):
            return num
        }
    }

    private var denominator: UnitSeries {
        switch self {
        case .unitless, .single, .multiply: return UnitSeries()
        case let .divide(_, denom): return denom
        }
    }

    private var simplified: UnitAnalysis {
        if numerator.isEmpty && denominator.isEmpty { return .unitless }
        switch self {
        case .unitless, .single: return self
        case let .multiply(m):
            return m.count > 1 ? self : .single(m.first!.key)
        case let .divide(num, denom):
            var (simpleNum, simpleDenom) = (num, denom)
            for (unit, count) in num {
                simpleNum[unit] -= simpleDenom[unit]
                simpleDenom[unit] -= count
            }
            return simpleDenom.isEmpty ?
              UnitAnalysis.multiply(simpleNum).simplified :
              UnitAnalysis.divide(numerator: simpleNum,
                                  denominator: simpleDenom)
        }
    }
    
    public static func ==(lhs: UnitAnalysis, rhs: UnitAnalysis) -> Bool {
        switch lhs {
        case .unitless: if case .unitless = rhs { return true }
        case let .single(leftMeasure):
            if case let .single(rightMeasure) = rhs {
                return leftMeasure == rightMeasure
            }
        case let .multiply(left):
            if case let .multiply(right) = rhs {
                return left == right
            }
        case let .divide(left):
            if case let .divide(right) = rhs {
                return left == right
            }
        }
        return false
    }

    public static func *(lhs: UnitAnalysis, rhs: UnitAnalysis) -> UnitAnalysis {
        var num = lhs.numerator
        num.add(rhs.numerator)
        var denom = lhs.denominator
        denom.add(rhs.denominator)
        return UnitAnalysis.divide(numerator: num,
                                   denominator: denom).simplified
    }

    public static func /(lhs: UnitAnalysis, rhs: UnitAnalysis) -> UnitAnalysis {
        var num = lhs.numerator
        num.add(rhs.denominator)
        var denom = lhs.denominator
        denom.add(rhs.numerator)
        return UnitAnalysis.divide(numerator: num,
                                   denominator: denom).simplified
    }
}
