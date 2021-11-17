import Foundation

class PirateCrew {
    private let workQueue = DispatchQueue(label: "crewWorkQ")

    enum Actions {
        case attackShip
        case digForGold
        case diveForJewels
    }

    func perform(action: Actions, callback: @escaping (Int) -> Void) {
        workQueue.async {
            var prizeValue = 0
            switch action {
            case .attackShip:
                prizeValue = 10000
            case .digForGold:
                prizeValue = 5000
            case .diveForJewels:
                prizeValue = 1000
            }
            callback(prizeValue)
        }
    }
}
