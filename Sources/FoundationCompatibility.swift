import Foundation

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public typealias PhysicalUnit = UnitAnalysis<Dimension>

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public typealias PhysicalMeasurement = MeasurementAnalysis<Dimension>

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *(lhs: Measurement<Dimension>, rhs: Measurement<Dimension>) -> PhysicalMeasurement {
    return PhysicalMeasurement(value: lhs.value * rhs.value,
                               unit: lhs.unit * rhs.unit)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func *(lhs: Dimension, rhs: Dimension) -> PhysicalUnit {
    return .single(lhs) * .single(rhs)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func /(lhs: Measurement<Dimension>, rhs: Measurement<Dimension>) -> PhysicalMeasurement {
    precondition(rhs.value != 0, "Can't divide by zero!")
    return PhysicalMeasurement(value: lhs.value / rhs.value,
                               unit: lhs.unit / rhs.unit)
}

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public func /(lhs: Dimension, rhs: Dimension) -> PhysicalUnit {
    return .single(lhs) / .single(rhs)
}
