import Foundation

protocol Peer {
    var name: String { get }
    var currentPosition: Position { get }
    func otherPlaneDidChangePosition(position: Position) -> Bool
}

protocol Mediator {
    func registerPeer(peer: Peer)
    func unregisterPeer(peer: Peer)
    func changePosition(peer: Peer, pos: Position) -> Bool
}

class AirplaneMediator: Mediator {
    private var peers: [String: Peer]
    private let queue = DispatchQueue(label: "posQ",attributes: .concurrent)

    init() {
        peers = [String: Peer]()
    }

    func registerPeer(peer: Peer) {
        queue.sync(flags: .barrier) { () in
            self.peers[peer.name] = peer
        }
    }

    func unregisterPeer(peer: Peer) {
        queue.sync(flags: .barrier) { () in
            _ = self.peers.removeValue(forKey: peer.name)
        }
    }

    func changePosition(peer: Peer, pos: Position) -> Bool {
        var result = false
        queue.sync() { () in

            let closerPeers = self.peers.values.filter { p in
                p.currentPosition.distanceFromRunway
                    <= pos.distanceFromRunway
            }

            for storedPeer in closerPeers {
                if peer.name != storedPeer.name,
                   storedPeer.otherPlaneDidChangePosition(position: pos)
                {
                    result = true
                }
            }
        }
        return result
    }
}
