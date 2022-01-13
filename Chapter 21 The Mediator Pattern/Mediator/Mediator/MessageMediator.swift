protocol MessagePeer {
    var name: String { get }
    func handleMessage(messageType: String, data: Any?) -> Any?
}

class MessageMediator {
    private var peers = [String: MessagePeer]()

    func registerPeer(peer: MessagePeer) {
        peers[peer.name] = peer
    }

    func unregisterPeer(peer: MessagePeer) {
        peers.removeValue(forKey: peer.name)
    }

    func sendMessage(caller: MessagePeer, messageType: String, data: Any) -> [Any?] {
        var results = [Any?]()
        for peer in peers.values where peer.name != caller.name {
            results.append(peer.handleMessage(messageType: messageType, data: data))
        }
        return results
    }
}
