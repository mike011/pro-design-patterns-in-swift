import Foundation

class PirateShip {
    struct ShipLocation {
        let northSouth: Int
        let eastWest: Int
    }

    private var currentPosition: ShipLocation
    private var movementQueue = DispatchQueue(label: "shipQ")

    init() {
        currentPosition = ShipLocation(northSouth: 5, eastWest: 5)
    }

    func moveToLocation(location: ShipLocation, callback: @escaping (ShipLocation) -> Void) {
        movementQueue.async{
            self.currentPosition = location
            callback(self.currentPosition)
        }
    }
}
