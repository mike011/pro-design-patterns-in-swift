import Foundation

let productLogger = Logger<Product>(callback: { p in

    var builder = ChangeRecordBuilder()
    builder.productName = p.name
    builder.category = p.category
    builder.value = String(p.stockLevel)
    builder.outerTag = "stockChange"

    var changeRecord = builder.changeRecord
    if changeRecord != nil {
        print(builder.changeRecord!)
    }
})

final class Logger<T> where T: NSObject, T: NSCopying {
    var dataItems: [T] = []
    var callback: (T) -> Void
    var arrayQ = DispatchQueue(label: "arrayQ",
                               qos: .default,
                               attributes: .concurrent,
                               autoreleaseFrequency: .inherit,
                               target: nil)
    var callbackQ = DispatchQueue(label: "callbackQ")

    fileprivate init(callback: @escaping (T) -> Void, protect: Bool = true) {
        self.callback = callback
        if protect {
            self.callback = { (item: T) in
                self.callbackQ.sync() { () in
                    callback(item)
                }
            }
        }
    }

    func logItem(item: T) {
        arrayQ.async(flags: .barrier) { () in
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
