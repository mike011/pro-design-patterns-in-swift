class SatelliteChannel: Channel {
    override func send(message: Message) {
        print("Satellite: \(message.contentToSend)")
    }
}

class PriorityMessage: ClearMessage {
    override var contentToSend: String {
        return "Important: \(super.contentToSend)"
    }
}
