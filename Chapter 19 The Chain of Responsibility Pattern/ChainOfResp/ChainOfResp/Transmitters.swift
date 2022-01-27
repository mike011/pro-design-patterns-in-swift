class Transmitter {
    var nextLink: Transmitter?

    required init() {}

    func sendMessage(message: Message, handled: inout Bool) -> Bool {
        if nextLink != nil {
            return nextLink!.sendMessage(message: message, handled: &handled)
        } else if !handled {
            print("End of chain reached. Message not sent")
        }
        return handled
    }

    class func createChain(localOnly: Bool) -> Transmitter? {
        let transmitterClasses: [Transmitter.Type]
            = localOnly ? [PriorityTransmitter.self, LocalTransmitter.self]
            : [PriorityTransmitter.self, LocalTransmitter.self, RemoteTransmitter.self]

        var link: Transmitter?

        for tClass in transmitterClasses.reversed() {
            let existingLink = link
            link = tClass.init()
            link?.nextLink = existingLink
        }

        return link
    }

    fileprivate class func matchEmailSuffix(message: Message) -> Bool {
        if let index = message.from.firstIndex(of: "@") {
            let domain = message.from[index...]
            return message.to.hasSuffix(domain)
        }
        return false
    }

    func sliceString(str: String, start: Int, end: Int) -> String {
        let data = Array(str)
        return String(data[start..<end])
    }

}

class LocalTransmitter: Transmitter {
    override func sendMessage(message: Message, handled: inout Bool) -> Bool {
        if !handled, Transmitter.matchEmailSuffix(message: message) {
            print("Message to \(message.to) sent locally")
            handled = true
        }
        return super.sendMessage(message: message, handled: &handled)
    }
}

class RemoteTransmitter: Transmitter {
    override func sendMessage(message: Message, handled: inout Bool) -> Bool {
        if !handled, !Transmitter.matchEmailSuffix(message: message) {
            print("Message to \(message.to) sent remotely")
            handled = true
        }
        return super.sendMessage(message: message, handled: &handled)
    }
}

class PriorityTransmitter: Transmitter {
    var totalMessages = 0
    var handledMessages = 0

    override func sendMessage(message: Message, handled: inout Bool) -> Bool {
        totalMessages += 1
        if !handled, message.subject.hasPrefix("Priority") {
            handledMessages += 1
            print("Message to \(message.to) sent as priority")
            print("Stats: Handled \(handledMessages) of \(totalMessages)")
            handled = true
        }
        return super.sendMessage(message: message, handled: &handled)
    }
}
