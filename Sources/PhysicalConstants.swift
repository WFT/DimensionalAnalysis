import Foundation

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
fileprivate let m = UnitLength.meters

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
fileprivate let s = UnitDuration.seconds

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public enum PhysicalConstant {
    public static let c = Measurement(value: 299_792_458, unit: m / s)
}
