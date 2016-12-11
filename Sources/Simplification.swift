import Foundation

// MARK: - Measurements

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

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom, Other>(lhs: Measurement<Denom>, rhs: Measurement<Div<Num, Mul<Denom, Other>>>) ->
  Measurement<Div<Num, Other>> {
    return Measurement(value: lhs.value * rhs.value,
                       unit: lhs.unit * rhs.unit)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom>(lhs: Measurement<Denom>, rhs: Measurement<Div<Num, Mul<Denom, Denom>>>) ->
  Measurement<Div<Num, Denom>> {
    return Measurement(value: lhs.value * rhs.value,
                       unit: lhs.unit * rhs.unit)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom>(lhs: Measurement<Div<Num, Mul<Denom, Denom>>>, rhs: Measurement<Denom>) ->
  Measurement<Div<Num, Denom>> {
    return rhs * lhs
}


@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom, Other>(lhs: Measurement<Denom>, rhs: Measurement<Div<Num, Mul<Other, Denom>>>) ->
  Measurement<Div<Num, Other>> {
    return Measurement(value: lhs.value * rhs.value,
                       unit: lhs.unit * rhs.unit)
}


@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom, Other>(lhs: Measurement<Div<Num, Mul<Denom, Other>>>, rhs: Measurement<Denom>) ->
  Measurement<Div<Num, Other>> {
    return rhs * lhs
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Num, Denom, Other>(lhs: Measurement<Div<Num, Mul<Other, Denom>>>, rhs: Measurement<Denom>) ->
  Measurement<Div<Num, Other>> {
    return rhs * lhs
}

// MARK: - Units

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

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator, Other>(lhs: Denominator, rhs: Div<Numerator, Mul<Denominator, Other>>) -> Div<Numerator, Other>
  where Numerator: Dimension, Denominator: Dimension {
    return Div(numerator: rhs.numerator, denominator: rhs.denominator.rhs)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator, Other>(lhs: Div<Numerator, Mul<Denominator, Other>>, rhs: Denominator) -> Div<Numerator, Other>
  where Numerator: Dimension, Denominator: Dimension {
    return rhs * lhs
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator, Other>(lhs: Denominator, rhs: Div<Numerator, Mul<Other, Denominator>>) -> Div<Numerator, Other>
  where Numerator: Dimension, Denominator: Dimension {
    return Div(numerator: rhs.numerator, denominator: rhs.denominator.lhs)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator, Other>(lhs: Div<Numerator, Mul<Other, Denominator>>, rhs: Denominator) -> Div<Numerator, Other>
  where Numerator: Dimension, Denominator: Dimension {
    return rhs * lhs
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator>(lhs: Denominator, rhs: Div<Numerator, Mul<Denominator, Denominator>>) -> Div<Numerator, Denominator>
  where Numerator: Dimension, Denominator: Dimension {
    return Div(numerator: rhs.numerator, denominator: rhs.denominator.rhs)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *<Numerator, Denominator>(lhs: Div<Numerator, Mul<Denominator, Denominator>>, rhs: Denominator) -> Div<Numerator, Denominator>
  where Numerator: Dimension, Denominator: Dimension {
    return rhs * lhs
}
