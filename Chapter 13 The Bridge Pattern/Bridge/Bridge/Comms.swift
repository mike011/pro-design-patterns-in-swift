 protocol ClearMessageChannel {
    func send(message: String)
 }

 protocol SecureMessageChannel {
    func send(message: String)
 }

 protocol PriorityMessageChannel {
    func send(message: String)
 }

class Communicator {
    private let clearChannel: ClearMessageChannel
    private let secureChannel: SecureMessageChannel
    private let priorityChannel: PriorityMessageChannel

    init (clearChannel: ClearMessageChannel, secureChannel: SecureMessageChannel, priorityChannel: PriorityMessageChannel) {
        self.clearChannel = clearChannel
        self.secureChannel = secureChannel
        self.priorityChannel = priorityChannel
    }


    func send(clearTextMessage: String) {
        clearChannel.send(message: clearTextMessage)
    }

    func send(secureMessage: String) {
        secureChannel.send(message: secureMessage)
    }

    func send(priorityMessage: String) {
        priorityChannel.send(message: priorityMessage)
    }
}
