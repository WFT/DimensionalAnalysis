import XCTest
import Foundation
@testable import DimensionalAnalysis

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class IntegrationTests: XCTestCase {
    // No acceleration
    func testSimple1DMotion() {
        let v = Measurement(value: 10, unit: m / s)
        let t = Measurement(value: 5, unit: s)
        let d = Measurement(value: 50, unit: m)

        XCTAssertEqual(v * t, d, "Velocity * Time != Distance")
        XCTAssertEqual(d / t, v, "Distance / Time != Velocity")
    }

    // Yes acceleration
    func testComplex1DMotion() {
        let startPosition = Measurement(value: 2, unit: m)
        let v = Measurement(value: 10, unit: m / s)
        let a = Measurement(value: 1, unit: m / (s * s))
        let t = Measurement(value: 5, unit: s)
        
        let expectedEnd = Measurement(value: 64.5, unit: m)

        // Help break up the expression:
        let constantVelocityComponent = v * t
        let accelerationComponent = 0.5 * a * t * t
        let calculatedEnd = startPosition +
          constantVelocityComponent +
          accelerationComponent
        
        XCTAssertEqual(calculatedEnd, expectedEnd, "Calculated end position != to expected end.")
    }
}
