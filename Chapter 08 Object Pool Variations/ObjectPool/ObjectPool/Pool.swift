import Foundation

class Pool<T: Sendable> {
    private var data = [T]()
    private var arrayQ = DispatchQueue(label: "arrayQ")
    private let semaphore: DispatchSemaphore

    init(items: [T]) {
        data.reserveCapacity(data.count)
        for item in items {
            data.append(item)
        }
        semaphore = DispatchSemaphore(value: items.count)
    }

    func getFromPool() -> T? {
        var result: T?
        semaphore.wait()
        arrayQ.sync {
            result = self.data.remove(at:0)
        }
        return result
    }

    func returnToPool(item: T) {
        arrayQ.async {
            self.data.append(item)
            self.semaphore.signal()
        }
    }
}
