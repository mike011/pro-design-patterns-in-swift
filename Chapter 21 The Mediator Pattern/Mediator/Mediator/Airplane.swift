import Foundation

struct Position {
    var distanceFromRunway: Int
    var height: Int
}

class Airplane: MessagePeer {
    var name: String
    private var currentPosition: Position
    private var mediator: MessageMediator
    private let queue = DispatchQueue(label: "posQ", attributes: .concurrent)

    init(name: String, initialPosition: Position, mediator: MessageMediator) {
        self.name = name
        currentPosition = initialPosition
        self.mediator = mediator
        mediator.registerPeer(peer: self)
    }

    func handleMessage(messageType: String, data: Any?) -> Any? {
        var result: Any?
        switch messageType {
        case "changePos":
            if let pos = data as? Position {
                result = otherPlaneDidChangePosition(position: pos)
            }
        default:
            fatalError("Unknown message type")
        }
        return result
    }

    func otherPlaneDidChangePosition(position: Position) -> Bool {
        var result = false
        queue.sync() { () in
            result = position.distanceFromRunway
                == self.currentPosition.distanceFromRunway
                && abs(position.height - self.currentPosition.height) < 1000
        }
        return result
    }

    func changePosition(newPosition: Position) {
        queue.sync(flags: .barrier) { () in
            self.currentPosition = newPosition

            let allResults = self.mediator.sendMessage(caller: self,
                                                       messageType: "changePos", data: newPosition)
            for result in allResults {
                if result as? Bool == true {
                    print("\(self.name): Too close! Abort!")
                    return
                }
            }
            print("\(self.name): Position changed")
        }
    }

    func land() {
        queue.sync(flags: .barrier) { () in
            self.currentPosition = Position(distanceFromRunway: 0, height: 0)
            self.mediator.unregisterPeer(peer: self)
            print("\(self.name): Landed")
        }
    }
}
