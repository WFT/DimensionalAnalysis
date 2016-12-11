import XCTest
import Foundation
@testable import DimensionalAnalysis

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class IntegrationTests: XCTestCase {
    func test1DMotion() {
        let v = Measurement(value: 10, unit: m / s)
        let t = Measurement(value: 5, unit: s)
        let d = Measurement(value: 50, unit: m)

        XCTAssertEqual(v * t, d, "Velocity * Time != Distance")
        XCTAssertEqual(d / t, v, "Distance / Time != Velocity")
    }
}
