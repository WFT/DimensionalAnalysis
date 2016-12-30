import XCTest
import Foundation
@testable import DimensionalAnalysis

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
class PhysicalUnitTests: XCTestCase {
    func testSimplification() {
        let mps = m / s
        XCTAssertEqual(mps * s, m,
                       "LHS unit simplification doesn't work.")
        XCTAssertEqual(s * mps, m,
                       "RHS unit simplification doesn't work.")
    }

    func testMultiplicativeCommutativity() {
        XCTAssertEqual(m * s, s * m)
        XCTAssertEqual(m * g * s, s * m * g)
        XCTAssertEqual(m * (g / s), (g / s) * m)
        XCTAssertEqual((m * g) / s, m * (g / s))
    }
}
