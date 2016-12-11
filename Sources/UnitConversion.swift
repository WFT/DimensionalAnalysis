import Foundation

// Used to help convert operators.
@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public class OperatorUnitConverter<Left, Right>: UnitConverter
  where Left: UnitConverter, Right: UnitConverter {
    let leftHand: Left
    let rightHand: Right
    let operation: (_ lhs: Double, _ rhs: Double) -> Double
    
    override public func baseUnitValue(fromValue value: Double) -> Double {
        let conversionRate = operation(leftHand.baseUnitValue(fromValue: 1), rightHand.baseUnitValue(fromValue: 1))
        
        return conversionRate * value
    }

    override public func value(fromBaseUnitValue value: Double) -> Double {
        let conversionRate = operation(leftHand.value(fromBaseUnitValue: 1), rightHand.value(fromBaseUnitValue: 1))
        return conversionRate * value
    }

    init(_ lhs: Left, _ op: @escaping (Double, Double) -> Double, _ rhs: Right) {
        leftHand = lhs
        rightHand = rhs
        operation = op
    }
}

// MARK: - Multiplication

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<L, R>(lhs: Measurement<L>, rhs: Measurement<R>) -> Measurement<Mul<L, R>>
  where L: Dimension, R: Dimension {
    return Measurement(value: lhs.value * rhs.value,
                       unit: lhs.unit * rhs.unit)
}

// MARK: - Division

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func /<L, R>(lhs: Measurement<L>, rhs: Measurement<R>) -> Measurement<Div<L, R>>
  where L: Dimension, R: Dimension {
    return Measurement(value: lhs.value / rhs.value,
                       unit: lhs.unit / rhs.unit)
}

// MARK: Simplification

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom>(lhs: Measurement<Denom>, rhs: Measurement<Div<Num, Denom>>) ->
  Measurement<Num>
  where Num: Dimension, Denom: Dimension {
    return Measurement(value: lhs.value * rhs.value,
                       unit: lhs.unit * rhs.unit)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom>(lhs: Measurement<Div<Num, Denom>>, rhs: Measurement<Denom>) ->
  Measurement<Num>
  where Num: Dimension, Denom: Dimension {
    return rhs * lhs
}
