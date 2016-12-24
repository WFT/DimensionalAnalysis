import Foundation

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public class Operation: Dimension {
    override public class func baseUnit() -> Operation {
        // This gets around some trickiness with the fact that
        // Div and Mul are generic types which can't be returned
        // by an @objc method, so their class function baseUnit()
        // must be @nonobjc. This is an @objc shim to allow
        // baseUnit() to work (albeit opaquely to Objective-C code).
        return self.baseUnit()
    }
}

// - MARK: Division
@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public class Div<Numerator, Denominator>: Operation
  where Numerator: Dimension, Denominator: Dimension {
    public let numerator: Numerator
    public let denominator: Denominator

    @nonobjc
    override public class func baseUnit() -> Div<Numerator, Denominator> {
        return Div(numerator: Numerator.baseUnit(),
                   denominator: Denominator.baseUnit())
    }

    override public func isEqual(_ obj: Any?) -> Bool {
        guard let cmp = obj as? Div<Numerator, Denominator> else {
            return false
        }
        return numerator == cmp.numerator && denominator == cmp.denominator
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
public func /<Num, Denom>(lhs: Num, rhs: Denom) -> Div<Num, Denom> {
    return Div(numerator: lhs, denominator: rhs)
}

// - MARK: Multiplication

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public class Mul<Left, Right>: Operation where Left: Dimension, Right: Dimension {
    public let lhs: Left
    public let rhs: Right

    @nonobjc
    override public class func baseUnit() -> Mul<Left, Right> {
        return Mul(Left.baseUnit(), Right.baseUnit())
    }

    override public func isEqual(_ obj: Any?) -> Bool {
        guard let cmp = obj as? Mul<Left, Right> else {
            return false
        }
        return lhs == cmp.lhs && rhs == cmp.rhs
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
public func *<L, R>(lhs: L, rhs: R) -> Mul<L, R> {
    return Mul(lhs, rhs)
}
