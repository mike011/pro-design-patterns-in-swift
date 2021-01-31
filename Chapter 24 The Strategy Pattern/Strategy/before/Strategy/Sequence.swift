final class Sequence {
    private var numbers: [Int]

    init(_ numbers: Int...) {
        self.numbers = numbers
    }

    func addNumber(value: Int) {
        numbers.append(value)
    }
}
