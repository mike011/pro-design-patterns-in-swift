protocol Strategy {
    func execute(values: [Int]) -> Int
}

class ClosureStrategy: Strategy {
    private let closure: ([Int]) -> Int

    init(_ closure: @escaping ([Int]) -> Int) {
        self.closure = closure
    }

    func execute(values: [Int]) -> Int {
        return closure(values)
    }
}

class SumStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(0, { $0 + $1 })
    }
}

class MultiplyStrategy: Strategy {
    func execute(values: [Int]) -> Int {
        return values.reduce(1, { $0 * $1 })
    }
}
