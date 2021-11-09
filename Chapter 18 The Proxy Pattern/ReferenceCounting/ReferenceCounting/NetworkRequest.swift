import Foundation

protocol NetworkConnection {
    func connect()
    func disconnect()
    func send(command: String)
}

class NetworkConnectionFactory {
    class func createNetworkConnection() -> NetworkConnection {
        return connectionProxy
    }

    private class var connectionProxy: NetworkConnection {
        enum singletonWrapper {
            static let singleton = NetworkRequestProxy()
        }
        return singletonWrapper.singleton
    }
}

private class NetworkConnectionImplementation: NetworkConnection {
    typealias me = NetworkConnectionImplementation

    func connect() { me.write(message: "Connect") }
    func disconnect() { me.write(message: "Disconnect") }

    func send(command: String) {
        me.write(message: "Command: \(command)")
        Thread.sleep(forTimeInterval: 1)
        me.write(message: "Command completed: \(command)")
    }

    private class func write(message: String) {
        queue.async() { () in
            print(message)
        }
    }

    private class var queue: DispatchQueue {
        enum singletonWrapper {
            static let singleton = DispatchQueue(label: "writeQ")
        }
        return singletonWrapper.singleton
    }
}

class NetworkRequestProxy: NetworkConnection {
    private let wrappedRequest: NetworkConnection
    private let queue = DispatchQueue(label: "commandQ")
    private var referenceCount = 0
    private var connected = false

    init() {
        wrappedRequest = NetworkConnectionImplementation()
    }

    func connect() { /* do nothing */ }
    func disconnect() { /* do nothing */ }

    func send(command: String) {
        referenceCount += 1
        queue.sync() { () in
            if !self.connected, self.referenceCount > 0 {
                self.wrappedRequest.connect()
                self.connected = true
            }
            self.wrappedRequest.send(command: command)
            self.referenceCount -= 1
            if self.connected, self.referenceCount == 0 {
                self.wrappedRequest.disconnect()
                self.connected = false
            }
        }
    }
}
