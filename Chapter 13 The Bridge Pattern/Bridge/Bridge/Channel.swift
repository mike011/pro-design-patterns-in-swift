protocol Channel {
    func send(message: Message)
}

class LandlineChannel: Channel {
    func send(message: Message) {
        print("Landline: \(message.contentToSend)")
    }
}

class WirelessChannel: Channel {
    func send(message: Message) {
        print("Wireless: \(message.contentToSend)")
    }
}
