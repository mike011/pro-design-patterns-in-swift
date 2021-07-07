import Foundation

var server = BackupServer.server

server.backup(item: DataItem(type: .Email, data: "joe@example.com"))
server.backup(item: DataItem(type: .Phone, data: "555-123-1133"))
globalLogger.log(msg: "Backed up 2 items to \(server.name)")

var otherServer = BackupServer.server
otherServer.backup(item: DataItem(type: .Email, data: "bob@example.com"))
globalLogger.log(msg: "Backed up 1 item to \(otherServer.name)")
globalLogger.printLog()


// Dealing with concurrency
let queue = DispatchQueue(label: "workQueue",
                          qos: .utility,
                          attributes: .concurrent,
                          autoreleaseFrequency: .inherit,
                          target: nil)
let group = DispatchGroup()

for _ in 0 ..< 100 {
    queue.async(group: group) {
        let data = DataItem(type: .Email, data: "bob@example.com")
        BackupServer.server.backup(item: data)
    }
}

group.wait()

print("\(server.getData().count) items were backed up")
