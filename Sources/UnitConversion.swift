import Foundation

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class OperatorUnitConverter<Left, Right>: UnitConverter
  where Left: UnitConverter, Right: UnitConverter {
    let leftHand: Left
    let rightHand: Right
    let operation: (_ lhs: Double, _ rhs: Double) -> Double
    
    override func baseUnitValue(fromValue value: Double) -> Double {
        return operation(leftHand.baseUnitValue(fromValue: value),
                         rightHand.baseUnitValue(fromValue: value))
        
    }

    override func value(fromBaseUnitValue value: Double) -> Double {
        return operation(leftHand.value(fromBaseUnitValue: value),
                         rightHand.value(fromBaseUnitValue: value))
    }

    init(_ lhs: Left, _ op: @escaping (Double, Double) -> Double, _ rhs: Right) {
        leftHand = lhs
        rightHand = rhs
        operation = op
    }
}

// MARK: - Multiplication

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
func *<L, R>(lhs: Measurement<L>, rhs: Measurement<R>) -> Measurement<Mul<L, R>>
  where L: Dimension, R: Dimension {
    return Measurement(value: lhs.value * rhs.value,
                       unit: lhs.unit * rhs.unit)
}

// MARK: Simplification

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
func *<Num, Denom>(lhs: Measurement<Denom>, rhs: Measurement<Div<Num, Denom>>) ->
  Measurement<Num>
  where Num: Dimension, Denom: Dimension {
    return Measurement(value: lhs.value * rhs.value,
                       unit: lhs.unit * rhs.unit)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
func *<Num, Denom>(lhs: Measurement<Div<Num, Denom>>, rhs: Measurement<Denom>) ->
  Measurement<Num>
  where Num: Dimension, Denom: Dimension {
    return rhs * lhs
}
