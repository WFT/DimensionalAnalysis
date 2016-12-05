import XCTest
import Foundation
@testable import DimensionalAnalysis

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class MultiplicationTests: XCTestCase {
    let km = UnitLength.kilometers
    let m = UnitLength.meters
    let s = UnitDuration.seconds

    func testSymbol() {
        let km2 = km * km
        XCTAssertEqual("(km)²", km2.symbol,
                       "Squared symbols do not properly compress.")
        let kmm = km * m
        XCTAssertEqual("(km * m)", kmm.symbol,
                       "Same unit type symbols get funky.")

        let kms = km * s
        XCTAssertEqual("(km * s)", kms.symbol,
                       "Different unit type symbols get funky.")
    }

    func testUnitSimplification() {
        let kmps = km / s
        XCTAssertEqual(kmps * s, km,
                       "LHS unit simplification doesn't work.")
        XCTAssertEqual(s * kmps, km,
                       "RHS unit simplification doesn't work.")
    }

    func testMeasurementSimplification() {
        let tenKM = Measurement(value: 10, unit: km)
        let tenKMPerSecond = Measurement(value: 10, unit: km / s)
        let oneSecond = Measurement(value: 1, unit: s)
        XCTAssertEqual(oneSecond * tenKMPerSecond, tenKM,
                       "LHS measurement simplification not working")
        XCTAssertEqual(tenKMPerSecond * oneSecond, tenKM,
                       "RHS measurement simplification not working")
    }

    func testUnitConversion() {
        let km2 = km * km
        let m2 = m * m
        XCTAssertEqual(km2, m2, "Units of same type do not convert.")
    }

    func testMeasurementConversion() {
        let oneKM = Measurement(value: 1, unit: km)
        let oneKM2inM2 = Measurement(value: 1000 * 1000, unit: m * m)
        let oneKM2 = oneKM * oneKM

        let base = oneKM2.unit.converter.baseUnitValue(fromValue: oneKM2.value)
        XCTAssertEqual(base, oneKM2inM2.value,
                       "Manual conversion failed.")

        XCTAssertEqual(oneKM * oneKM, oneKM2inM2,
                       "Implicit conversion failed.")

    }
}
