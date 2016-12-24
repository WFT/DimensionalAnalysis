// Reimplementation of Foundation.Measurement using our types
public struct MeasurementAnalysis<UnitSymbol: Hashable> {
    public typealias UnitType = UnitAnalysis<UnitSymbol>

    public let unit: UnitType
    public let value: Double

    public init(value: Double, unit: UnitType) {
        self.value = value
        self.unit = unit
    }

    public static func +(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol>? {
        guard lhs.unit == rhs.unit else { return nil }
        return MeasurementAnalysis(unit: lhs.unit,
                                   value: lhs.value + rhs.value)
    }

    public static func -(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol>? {
        guard lhs.unit == rhs.unit else { return nil }
        return MeasurementAnalysis(unit: lhs.unit,
                                   value: lhs.value - rhs.value)
    }

    public static func *(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol> {
        return MeasurementAnalysis(unit: lhs.unit * rhs.unit,
                                   value: lhs.value * rhs.value)
    }

    public static func /(lhs: MeasurementAnalysis<UnitSymbol>,
                         rhs: MeasurementAnalysis<UnitSymbol>) ->
      MeasurementAnalysis<UnitSymbol> {
        return MeasurementAnalysis(unit: lhs.unit / rhs.unit,
                                   value: lhs.value / rhs.value)
    }
}
