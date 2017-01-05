#if os(iOS) || os(OSX) || os(tvOS)
import Darwin
#else
import Glibc
#endif

fileprivate extension Double {
    func power(_ exponent: Double) -> Double {
        return pow(self, exponent)
    }
}

// Reimplementation of Foundation.Measurement using our types
public struct MeasurementAnalysis<UnitSymbol: Hashable>: Equatable {
    public typealias UnitType = UnitAnalysis<UnitSymbol>

    public let unit: UnitType
    public let value: Double

    public init(value: Double, unit: UnitType) {
        self.value = value
        self.unit = unit
    }

    public func pow(_ exponent: Double) -> MeasurementAnalysis {
        return MeasurementAnalysis(value: value.power(exponent),
                                   unit: unit.pow(exponent))
    }

    public static func ==(lhs: MeasurementAnalysis<UnitSymbol>,
                          rhs: MeasurementAnalysis<UnitSymbol>) -> Bool {
        return lhs.value == rhs.value && lhs.unit == rhs.unit
    }

    public static func +(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol>? {
        guard lhs.unit == rhs.unit else { return nil }
        return MeasurementAnalysis(value: lhs.value + rhs.value,
                                   unit: lhs.unit)
    }

    public static func -(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol>? {
        guard lhs.unit == rhs.unit else { return nil }
        return MeasurementAnalysis(value: lhs.value - rhs.value,
                                   unit: lhs.unit)
    }

    public static func *(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol> {
        return MeasurementAnalysis(value: lhs.value * rhs.value,
                                   unit: lhs.unit * rhs.unit)
                                   
    }

    public static func /(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol> {
        return MeasurementAnalysis(value: lhs.value / rhs.value,
                                   unit: lhs.unit / rhs.unit)
                                   
    }

    public static func *(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: Double) ->
      MeasurementAnalysis<UnitSymbol> {
        return MeasurementAnalysis(value: lhs.value * rhs,
                                   unit: lhs.unit)
                                   
    }

    public static func *(lhs: Double, rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol> {
        return rhs * lhs
                                   
    }

    public static func /(lhs: Double, rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol> {
        return rhs * lhs
                                   
    }
}
