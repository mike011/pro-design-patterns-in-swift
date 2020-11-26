import Foundation

final class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore: DispatchSemaphore
    private var queue: DispatchQueue
    private var itemsCreated = 0

    private init() {
        semaphore = DispatchSemaphore(value: connectionCount)
        queue = DispatchQueue(label: "networkpoolQ")
    }

    private func doGetConnection() -> NetworkConnection {
        _ = semaphore.wait(timeout: .distantFuture)
        var result: NetworkConnection?
        queue.sync { () in
            if self.connections.count > 0 {
                result = self.connections.remove(at: 0)
            } else if self.itemsCreated < self.connectionCount {
                result = NetworkConnection()
                self.itemsCreated += 1
            }
        }
        return result!
    }

    private func doReturnConnection(conn: NetworkConnection) {
        queue.async { () in
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
