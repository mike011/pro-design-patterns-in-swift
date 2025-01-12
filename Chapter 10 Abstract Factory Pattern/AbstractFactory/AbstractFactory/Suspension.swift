import Foundation

@objc protocol Suspension: Sendable {
    var suspensionType: SuspensionOption { get }

    static func getInstance() -> Suspension
}

final class RoadSuspension: Suspension, @unchecked Sendable {
    var suspensionType = SuspensionOption.STANDARD

    private init() {}

    class func getInstance() -> Suspension {
        return RoadSuspension()
    }
}

final class OffRoadSuspension: Suspension, @unchecked Sendable {
    var suspensionType = SuspensionOption.SOFT

    private init() {}

    class func getInstance() -> Suspension {
        return OffRoadSuspension()
    }
}

final class RaceSuspension: NSObject, NSCopying, Suspension, @unchecked Sendable {

    var suspensionType = SuspensionOption.SPORTS

    override private init() {}

    func copy(with zone: NSZone? = nil) -> Any {
        return RaceSuspension()
    }

    private class var prototype: RaceSuspension {
        enum SingletonWrapper {
            static let singleton = RaceSuspension()
        }
        return SingletonWrapper.singleton
    }

    class func getInstance() -> Suspension {
        return prototype.copy() as! any Suspension as Suspension
    }
}
