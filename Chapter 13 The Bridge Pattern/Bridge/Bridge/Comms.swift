// protocol ClearMessageChannel {
//    func send(message:String);
// }
//
// protocol SecureMessageChannel {
//    func sendEncryptedMessage(message:String);
// }
//
// protocol PriorityMessageChannel {
//    func sendPriority(message:String);
// }

class Communicator {
    private let channnel: Channel

    init(channel: Channel.Channels) {
        channnel = Channel.getChannel(channel)
    }

    private func sendMessage(msg: Message) {
        msg.prepareMessage()
        channnel.sendMessage(msg)
    }

    func sendCleartextMessage(message: String) {
        sendMessage(ClearMessage(message: message))
    }

    func sendSecureMessage(message: String) {
        sendMessage(EncryptedMessage(message: message))
    }

    func sendPriorityMessage(message: String) {
        sendMessage(PriorityMessage(message: message))
    }
}
