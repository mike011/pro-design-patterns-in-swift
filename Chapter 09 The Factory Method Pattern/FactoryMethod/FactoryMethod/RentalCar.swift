class RentalCar {
    private var nameBV: String
    private var passengersBV: Int
    private var priceBV: Float

    fileprivate init(name: String, passengers: Int, price: Float) {
        nameBV = name
        passengersBV = passengers
        priceBV = price
    }

    final var name: String { return nameBV }
    final var passengers: Int { return passengersBV }
    final var pricePerDay: Float { return priceBV }

    class func createRentalCar(passengers: Int) -> RentalCar? {
        var carImpl: RentalCar.Type?
        switch passengers {
        case 0 ... 3:
            carImpl = Compact.self
        case 4 ... 8:
            carImpl = SUV.self
        default:
            carImpl = nil
        }
        return carImpl?.createRentalCar(passengers: passengers)
    }
}

class Compact: RentalCar {
    fileprivate convenience init() {
        self.init(name: "VW Golf", passengers: 3, price: 20)
    }

    override fileprivate init(name: String, passengers: Int, price: Float) {
        super.init(name: name, passengers: passengers, price: price)
    }

    override class func createRentalCar(passengers: Int) -> RentalCar? {
        if passengers < 2 {
            return sharedInstance
        } else {
            return SmallCompact.sharedInstance
        }
    }

    class var sharedInstance: RentalCar {
        enum SingletonWrapper {
            static let singleton = Compact()
        }
        return SingletonWrapper.singleton
    }
}

class SmallCompact: Compact {
    private init() {
        super.init(name: "Ford Fiesta", passengers: 3, price: 15)
    }

    override class var sharedInstance: RentalCar {
        enum SingletonWrapper {
            static let singleton = SmallCompact()
        }
        return SingletonWrapper.singleton
    }
}

class SUV: RentalCar {
    private init() {
        super.init(name: "Cadillac Escalade", passengers: 8, price: 75)
    }

    override class func createRentalCar(passengers _: Int) -> RentalCar? {
        return SUV()
    }
}
