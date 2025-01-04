import Foundation

@MainActor
class Pool<T: Sendable>: Sendable {
    private var data = [T]()

    init(items: [T]) {
        data.reserveCapacity(data.count)
        for item in items {
            data.append(item)
        }
    }

    func getFromPool() -> T? {
        var result: T?
        if !data.isEmpty {
            result = data.remove(at:0)
        }
        return result
    }

    func returnToPool(item: T) {
        data.append(item)
    }
}
