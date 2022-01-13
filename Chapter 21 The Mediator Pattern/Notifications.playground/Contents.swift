import Foundation

let notifier = NotificationCenter.default

@objc class NotificationPeer: NSObject {
    let name: String

    init(name: String) {
        self.name = name
        super.init()
        notifier.addObserver(self,
                             selector: #selector(receiveMessage),
                             name: NSNotification.Name("message"),
                             object: nil)
    }

    func sendMessage(message: String) {
        notifier.post(name: NSNotification.Name(rawValue: "message"),
                      object: message)
    }

    @objc func receiveMessage(_ notification: Notification) {
        print("Peer \(name) received message: \(notification.object ?? "empty message")")
    }
}

let p1 = NotificationPeer(name: "peer 1")
let p2 = NotificationPeer(name: "peer 2")
let p3 = NotificationPeer(name: "peer 3")
let p4 = NotificationPeer(name: "peer 4")

p3.sendMessage(message: "Hello!")
