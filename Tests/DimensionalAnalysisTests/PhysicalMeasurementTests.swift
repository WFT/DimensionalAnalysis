import XCTest
import Foundation
@testable import DimensionalAnalysis

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class PhysicalMeasurementTests: XCTestCase {
    func testMeasurementCommutativity() {
        let a = PhysicalMeasurement(value: 10, unit: m / (s * s))
        let t = PhysicalMeasurement(value: 2, unit: s)
        let d1 = (0.5 * (a * (t * t)))
        let d2 = 0.5 * a * t * t
        let d3 = ((0.5 * a) * (t * t))
        let d4 = (((0.5 * a) * t) * t)
        XCTAssertEqual(d1, d2)
        XCTAssertEqual(d2, d3)
        XCTAssertEqual(d3, d4)
    }

    func testMeasurementSimplification() {
        let tenM = PhysicalMeasurement(value: 10, unit: m)
        let tenMPerSecond = PhysicalMeasurement(value: 10, unit: m / s)
        let oneSecond = PhysicalMeasurement(value: 1, unit: s)
        XCTAssertEqual(oneSecond * tenMPerSecond, tenM,
                       "LHS measurement simplification not working")
        XCTAssertEqual(tenMPerSecond * oneSecond, tenM,
                       "RHS measurement simplification not working")
    }    
}
