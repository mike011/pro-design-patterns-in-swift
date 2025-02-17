class SatelliteChannel: Channel {
    func send(message: Message) {
        print("Satellite: \(message.contentToSend)")
    }
}

class PriorityMessage: ClearMessage {
    func send(message: Message) {
        print("Important: \(message.contentToSend)")
    }
}
