import Foundation

let productLogger = Logger<Product>(callback: { p in
    print("Change: \(p.name) \(p.stockLevel) items in stock")
})

final class Logger<T: Sendable>: @unchecked Sendable where T: NSObject, T: NSCopying {
    var dataItems: [T] = []
    var callback: (T) -> Void
    var arrayQ = DispatchQueue(label: "arrayQ",
                               qos: .background,
                               attributes: .concurrent,
                               autoreleaseFrequency: .inherit,
                               target: nil)
    var callbackQ = DispatchQueue(label: "callbackQ")

    fileprivate init(callback: @escaping (T) -> Void, protect: Bool = true) {
        self.callback = callback
        if protect {
            self.callback = { (item: T) in
                self.callbackQ.sync {
                    callback(item)
                }
            }
        }
    }

    func logItem(item: T) {
        arrayQ.async(group: nil, qos: .background, flags: .barrier) {
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        }
    }

    func processItems(callback: (T) -> Void) {
        arrayQ.sync() { () in
            for item in self.dataItems {
                callback(item)
            }
        }
    }
}
