import Foundation

protocol Flyweight {
    subscript(_: Coordinate) -> Int? { get set }
    var total: Int { get }
    var count: Int { get }
}

extension Dictionary {
    init(setupFunc: () -> [(Key, Value)]) {
        self.init()
        for item in setupFunc() {
            self[item.0] = item.1
        }
    }
}

class FlyweightFactory {
    class func createFlyweight() -> Flyweight {
        return FlyweightImplementation(extrinsic: extrinsicData)
    }

    private class var extrinsicData: [Coordinate: Cell] {
        enum singletonWrapper {
            static let singletonData = [Coordinate: Cell](
                setupFunc: { () in
                    var results = [(Coordinate, Cell)]()
                    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                    let rows = 50
                    for stringIndex in letters.indices {
                        let colLetter = letters[stringIndex]
                        for rowIndex in 1 ... rows {
                            let cell = Cell(col: colLetter, row: rowIndex,
                                            val: rowIndex)
                            results.append((cell.coordinate, cell))
                        }
                    }
                    return results
                }
            )
        }
        return singletonWrapper.singletonData
    }
}

class FlyweightImplementation: Flyweight {
    private let extrinsicData: [Coordinate: Cell]
    private var intrinsicData: [Coordinate: Cell]
    private let queue: DispatchQueue

    fileprivate init(extrinsic: [Coordinate: Cell]) {
        extrinsicData = extrinsic
        intrinsicData = [Coordinate: Cell]()
        queue = DispatchQueue.init(label: "dataQ", attributes: .concurrent)
    }

    subscript(key: Coordinate) -> Int? {
        get {
            var result: Int?
            queue.sync() { () in
                if let cell = self.intrinsicData[key] {
                    result = cell.value
                } else {
                    result = self.extrinsicData[key]?.value
                }
            }
            return result
        }
        set(value) {
            if value != nil {
                queue.async(flags: .barrier) { () in
                    self.intrinsicData[key] = Cell(col: key.col,
                                                   row: key.row, val: value!)
                }
            }
        }
    }

    var total: Int {
        var result = 0
        queue.sync() { () in
            result = self.extrinsicData.values.reduce(0) { total, cell in
                if let intrinsicCell = self.intrinsicData[cell.coordinate] {
                    return total + intrinsicCell.value
                } else {
                    return total + cell.value
                }
            }
        }
        return result
    }

    var count: Int {
        var result = 0
        queue.sync() { () in
            result = self.intrinsicData.count
        }
        return result
    }
}
