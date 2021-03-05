import Foundation

final class Logger<T> where T: NSObject, T: NSCopying {
    var dataItems: [T] = []
    var callback: (T) -> Void
    var arrayQ = DispatchQueue(label: "arrayQ", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
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
        arrayQ.async(flags: .barrier) {
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        }
    }

    func processItems(callback: (T) -> Void) {
        arrayQ.sync {
            for item in self.dataItems {
                callback(item)
            }
        }
    }
}
