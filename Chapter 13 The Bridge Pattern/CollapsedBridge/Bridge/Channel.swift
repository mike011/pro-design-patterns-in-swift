class Channel {
    enum Name {
        case landline
        case wireless
        case satellite
    }

    class func getChannel(channelType: Name) -> Channel {
        switch channelType {
        case .landline:
            return LandlineChannel()
        case .wireless:
            return WirelessChannel()
        case .satellite:
            return SatelliteChannel()
        }
    }

    func send(message _: Message) {
        fatalError("Not implemented")
    }
}

class LandlineChannel: Channel {
    override func send(message: Message) {
        print("Landline: \(message.contentToSend)")
    }
}

class WirelessChannel: Channel {
    override func send(message: Message) {
        print("Wireless: \(message.contentToSend)")
    }
}
