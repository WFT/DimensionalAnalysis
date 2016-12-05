import Foundation

// - MARK: Division
@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public class Div<Numerator, Denominator>: Dimension
  where Numerator: Dimension, Denominator: Dimension {
    let numerator: Numerator
    let denominator: Denominator

    @nonobjc
    override public class func baseUnit() -> Div<Numerator, Denominator> {
        return Div(numerator: Numerator.baseUnit(),
                   denominator: Denominator.baseUnit())
    }

    public init(numerator: Numerator, denominator: Denominator) {
        self.numerator = numerator
        self.denominator = denominator
        super.init(symbol: "(\(numerator.symbol) / \(denominator.symbol))",
                   converter: OperatorUnitConverter(numerator.converter, /, denominator.converter))
    }

    public required init?(coder c: NSCoder) {
        numerator = Numerator()
        denominator = Denominator()
        super.init(coder: c)
    }
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func /<Num, Denom>(lhs: Num, rhs: Denom) -> Div<Num, Denom>
  where Num: Dimension, Denom: Dimension {
    return Div(numerator: lhs, denominator: rhs)
}

// - MARK: Multiplication

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public class Mul<Left, Right>: Dimension where Left: Dimension, Right: Dimension {
    let lhs: Left
    let rhs: Right

    @nonobjc
    override public class func baseUnit() -> Mul<Left, Right> {
        return Mul(Left.baseUnit(), Right.baseUnit())
    }

    override public func isEqual(_ obj: Any?) -> Bool {
        return obj is Mul<Left, Right>
    }
    
    public init(_ left: Left, _ right: Right) {
        self.lhs = left
        self.rhs = right
        let symbol: String
        if left.symbol == right.symbol { symbol = "(\(left.symbol))²" }
        else { symbol = "(\(left.symbol) * \(right.symbol))" }
        super.init(symbol: symbol,
                   converter: OperatorUnitConverter(left.converter, *, right.converter))
    }

    public required init?(coder c: NSCoder) {
        lhs = Left()
        rhs = Right()
        super.init(coder: c)
    }
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<L, R>(lhs: L, rhs: R) -> Mul<L, R>
  where L: Dimension, R: Dimension {
    return Mul(lhs, rhs)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator>(lhs: Denominator, rhs: Div<Numerator, Denominator>) -> Numerator
  where Numerator: Dimension, Denominator: Dimension {
    return rhs.numerator
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator>(lhs: Div<Numerator, Denominator>, rhs: Denominator) -> Numerator
  where Numerator: Dimension, Denominator: Dimension {
    return rhs * lhs
}
