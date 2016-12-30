import XCTest
import Foundation
@testable import DimensionalAnalysis

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class IntegrationTests: XCTestCase {
    // No acceleration
    func testSimple1DMotion() {
        let v = PhysicalMeasurement(value: 10, unit: m / s)
        let t = PhysicalMeasurement(value: 5, unit: s)
        let d = PhysicalMeasurement(value: 50, unit: m)

        XCTAssertEqual(v * t, d, "Velocity * Time != Distance")
        XCTAssertEqual(d / t, v, "Distance / Time != Velocity")
    }

    // Yes acceleration
    func testComplex1DMotion() {
        let startPosition = PhysicalMeasurement(value: 2, unit: m)
        let v = PhysicalMeasurement(value: 10, unit: m / s)
        let a = PhysicalMeasurement(value: 1, unit: m / (s * s))
        let t = PhysicalMeasurement(value: 5, unit: s)
        
        let expectedEnd = PhysicalMeasurement(value: 64.5, unit: m)

        // Help break up the expression:
        let constantVelocityComponent = v * t
        let accelerationComponent = 0.5 * a * t * t
        guard let noaccStart = startPosition + constantVelocityComponent else {
            XCTFail("\(startPosition) + \(constantVelocityComponent) == nil")
            return
        }
        
        let calculatedEnd = noaccStart + accelerationComponent
        
        XCTAssertEqual(calculatedEnd, expectedEnd,
                       "Calculated end position != to expected end.")
    }
}
