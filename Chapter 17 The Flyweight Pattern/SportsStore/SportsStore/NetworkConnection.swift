import Foundation

class NetworkConnection {
    private let flyweight: NetConnFlyweight

    init() {
        flyweight = NetConnFlyweightFactory.createFlyweight()
    }

    func getStockLevel(name: String) -> Int? {
        NSThread.sleepForTimeInterval(Double(rand() % 2))
        return flyweight.getStockLevel(name)
    }
}
