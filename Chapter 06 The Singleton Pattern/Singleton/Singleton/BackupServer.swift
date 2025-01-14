import Foundation

class DataItem {
    enum ItemType: String {
        case Email = "Email Address"
        case Phone = "Telephone Number"
        case Card = "Credit Card Number"
    }

    var type: ItemType
    var data: String

    init(type: ItemType, data: String) {
        self.type = type; self.data = data
    }
}

final class BackupServer: @unchecked Sendable {
    let name: String
    private var data = [DataItem]()
    private let arrayQ = DispatchQueue(label: "arrayQ")

    private init(name: String) {
        self.name = name
        globalLogger.log(msg: "Created new server \(name)")
    }

    func backup(item: DataItem) {
        arrayQ.sync() { () in
            self.data.append(item)
            globalLogger.log(
                msg: "\(self.name) backed up item of type \(item.type.rawValue)")
        }
    }

    func getData() -> [DataItem] {
        return data
    }

    class var server: BackupServer {
        enum SingletonWrapper {
            static let singleton = BackupServer(name: "MainServer")
        }
        return SingletonWrapper.singleton
    }
}
