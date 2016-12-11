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

    func testCommutativity() {
        let a = Measurement(value: 10, unit: m / (s * s))
        let t = Measurement(value: 2, unit: s)
        let d1 = (0.5 * (a * (t * t)))
        let d2 = 0.5 * a * t * t
        let d3 = ((0.5 * a) * (t * t))
        let d4 = (((0.5 * a) * t) * t)
        XCTAssertEqual(d1, d2)
        XCTAssertEqual(d2, d3)
        XCTAssertEqual(d3, d4)
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
    
    func testMeasurementConversion() {
        let oneKM = Measurement(value: 1, unit: km)
        let oneKM2inM2 = Measurement(value: 1000 * 1000, unit: m * m)
        let oneKM2 = oneKM * oneKM
        
        let base = oneKM2.unit.converter.baseUnitValue(fromValue: oneKM2.value)
        XCTAssertEqual(base, oneKM2inM2.value,
                       "Manual conversion to base unit failed.")

        let nonbase = oneKM2.unit.converter.value(fromBaseUnitValue: oneKM2inM2.value)

        XCTAssertEqual(nonbase, oneKM2.value,
                       "Manual conversion to non base unit failed.")

        XCTAssertEqual(oneKM2, oneKM2inM2,
                       "Implicit conversion failed.")

    }
}
