import Foundation

let facade = PirateFacade()
if let prize = facade.getTreasure(type: .ship) {
    facade.crew.perform(action: .diveForJewels,
                        callback: { secondPrize in
        print("Prize: \(prize + secondPrize) pieces of eight")
    })
}

_ = FileHandle.standardInput.availableData
