 class CommunicatorBridge : ClearMessageChannel, SecureMessageChannel,
        PriorityMessageChannel {
    private var channel: Channel

     init(channel: Channel) {
        self.channel = channel
    }

    func send(message: String) {
        let msg = ClearMessage(message: message)
        sendMessage(msg: msg)
    }

     func sendEncryptedMessage(message encryptedText: String) {
        let msg = EncryptedMessage(message: encryptedText)
         sendMessage(msg: msg)
    }

    func sendPriority(message: String) {
        sendMessage(msg:PriorityMessage(message: message))
    }

    private func sendMessage(msg:Message) {
        msg.prepareMessage()
        channel.send(message: msg)
    }
 }
