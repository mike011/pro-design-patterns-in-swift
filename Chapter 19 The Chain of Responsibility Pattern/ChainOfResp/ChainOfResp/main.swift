let messages = [
    Message(from: "bob@example.com", to: "joe@example.com",
            subject: "Free for lunch?"),
    Message(from: "joe@example.com", to: "alice@acme.com",
            subject: "New Contracts"),
    Message(from: "pete@example.com", to: "all@example.com",
            subject: "Priority: All-Hands Meeting"),
]

if let chain = Transmitter.createChain(localOnly: true) {
    for msg in messages {
        var wasHandled = false
        let handled = chain.sendMessage(message: msg, handled: &wasHandled)
        print("Message sent: \(handled)")
    }
}
