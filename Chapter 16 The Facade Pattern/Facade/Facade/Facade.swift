import Foundation

enum TreasureTypes {
    case ship
    case buried
    case sunken
}

class PirateFacade {
    private let map = TreasureMap()
    private let ship = PirateShip()
    let crew = PirateCrew()

    func getTreasure(type: TreasureTypes) -> Int? {
        var prizeAmount: Int?

        // select the treasure type
        var treasuareMap: TreasureMap.Treasures
        var crewWork: PirateCrew.Actions

        switch type {
        case .ship:
            treasuareMap = .galleon
            crewWork = .attackShip
        case .buried:
            treasuareMap = .buriedGold
            crewWork = .digForGold
        case .sunken:
            treasuareMap = .sunkenJewels
            crewWork = .diveForJewels
        }

        let treasureLocation = map.findTreasure(type: treasuareMap)

        // convert from map to ship coordinates
        let sequence: [Character] = ["A", "B", "C", "D", "E", "F", "G"]
        let eastWestPos = sequence.firstIndex (where: {$0 == treasureLocation.gridLetter})
        let shipTarget = PirateShip.ShipLocation(northSouth:
            Int(treasureLocation.gridNumber), eastWest: eastWestPos!)

        let semaphore = DispatchSemaphore(value: 0)

        // relocate ship
        ship.moveToLocation(location: shipTarget, callback: { _ in
            self.crew.perform(action: crewWork) { prize in
                prizeAmount = prize
                semaphore.signal()
            }
        })

        semaphore.wait()
        return prizeAmount
    }
}
