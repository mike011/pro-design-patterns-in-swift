import Foundation

final class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore: DispatchSemaphore
    private var queue: DispatchQueue

    private init() {
        for _ in 0 ..< connectionCount {
            connections.append(NetworkConnection())
        }
        semaphore = DispatchSemaphore(value: connectionCount)
        queue = DispatchQueue(label: "networkpoolQ")
    }

    private func doGetConnection() -> NetworkConnection {
        semaphore.wait()
        var result: NetworkConnection?
        queue.sync {
            result = self.connections.remove(at: 0)
        }
        return result!
    }

    private func doReturnConnection(conn: NetworkConnection) {
        queue.async() { () in
            self.connections.append(conn)
            self.semaphore.signal()
        }
    }

    class func getConnection() -> NetworkConnection {
        return sharedInstance.doGetConnection()
    }

    class func returnConnecton(conn: NetworkConnection) {
        sharedInstance.doReturnConnection(conn: conn)
    }

    private class var sharedInstance: NetworkPool {
        enum SingletonWrapper {
            static let singleton = NetworkPool()
        }
        return SingletonWrapper.singleton
    }
}
