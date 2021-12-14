import Foundation

class Owner: NSObject, NSCopying {

    var name: String
    var city: String

    init(name: String, city: String) {
        self.name = name; self.city = city
    }

    func copy(with zone: NSZone? = nil) -> Any {
        print("Copy")
        return Owner(name: name, city: city)
    }
}

class FlyweightFactory {
    class func createFlyweight() -> Flyweight {
        return Flyweight(owner: ownerSingleton)
    }

    private class var ownerSingleton: Owner {
        enum singletonWrapper {
            static let singleon = Owner(name: "Anonymous", city: "Anywhere")
        }
        return singletonWrapper.singleon
    }
}

class Flyweight {
    private let extrinsicOwner: Owner
    private var intrinsicOwner: Owner?

    init(owner: Owner) {
        extrinsicOwner = owner
    }

    var name: String {
        get {
            return intrinsicOwner?.name ?? extrinsicOwner.name
        }
        set(value) {
            decoupleFromExtrinsic()
            intrinsicOwner?.name = value
        }
    }

    var city: String {
        get {
            return intrinsicOwner?.city ?? extrinsicOwner.city
        }
        set(value) {
            decoupleFromExtrinsic()
            intrinsicOwner?.city = value
        }
    }

    private func decoupleFromExtrinsic() {
        if intrinsicOwner == nil {
            intrinsicOwner = extrinsicOwner.copy(with: nil) as? Owner
        }
    }
}
