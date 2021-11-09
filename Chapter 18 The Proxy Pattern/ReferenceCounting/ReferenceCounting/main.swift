import Foundation

let queue = DispatchQueue(label: "reqeustQ",
                          qos: .default,
                          attributes: .concurrent,
                          autoreleaseFrequency: .inherit,
                          target: nil)

for count in 0 ..< 3 {
    let connection = NetworkConnectionFactory.createNetworkConnection()

    queue.async() { () in
        connection.connect()
        connection.send(command: "Command: \(count)")
        connection.disconnect()
    }
}

_ = FileHandle.standardInput.availableData
