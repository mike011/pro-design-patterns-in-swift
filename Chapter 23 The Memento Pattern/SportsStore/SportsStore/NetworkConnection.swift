import Foundation

class NetworkConnection {
    private let flyweight: NetConnFlyweight

    init() {
        flyweight = NetConnFlyweightFactory.createFlyweight()
    }

    func getStockLevel(name: String) -> Int? {
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        return flyweight.getStockLevel(name: name)
    }

    func setStockLevel(name: String, level: Int) {
        print("Stock update: \(name) = \(level)")
    }
}
