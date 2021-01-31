let sequence = Sequence(1, 2, 3, 4)
sequence.addNumber(value: 10)
sequence.addNumber(value: 20)

let sumStrategy = SumStrategy()
let multiplyStrategy = MultiplyStrategy()

let sum = sequence.compute(strategy: sumStrategy)
print("Sum: \(sum)")

let multiply = sequence.compute(strategy: multiplyStrategy)
print("Multiply: \(multiply)")

let filterThreshold = 10
let cstrategy = ClosureStrategy { values in
    values.filter { $0 < filterThreshold }.reduce(0) { $0 + $1 }
}

let filteredSum = sequence.compute(strategy: cstrategy)
print("Filtered Sum: \(filteredSum)")
