class Communicator {
    private let channnel: Channel

    init(channel: Channel.Name) {
        channnel = Channel.getChannel(channelType: channel)
    }

    private func send(message: Message) {
        message.prepareMessage()
        channnel.send(message: message)
    }

    func send(clearTextMessage: String) {
        send(message: ClearMessage(message: clearTextMessage))
    }

    func send(secureMessage: String) {
        send(message: EncryptedMessage(message: secureMessage))
    }

    func send(priorityMessage: String) {
        send(message: PriorityMessage(message: priorityMessage))
    }
}
