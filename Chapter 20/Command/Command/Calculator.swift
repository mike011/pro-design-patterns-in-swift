import Foundation

class Calculator {
    private(set) var total = 0
    typealias CommandClosure = ((Calculator) -> Void)
    private var history = [CommandClosure]()
    private var queue = DispatchQueue(label: "arrayQ")
    func add(amount: Int) {
        addMacro(method: Calculator.add, amount: amount)
        total += amount
    }

    func subtract(amount: Int) {
        addMacro(method: Calculator.subtract, amount: amount)
        total -= amount
    }

    func multiply(amount: Int) {
        addMacro(method: Calculator.multiply, amount: amount)
        total = total * amount
    }

    func divide(amount: Int) {
        addMacro(method: Calculator.divide, amount: amount)
        total = total / amount
    }

    private func addMacro(method: @escaping (Calculator) -> (Int) -> Void, amount: Int) {
        queue.sync() { () in
            self.history.append { calc in method(calc)(amount) }
        }
    }

    func getMacroCommand() -> ((Calculator) -> Void) {
        var commands = [CommandClosure]()
        queue.sync() { () in
            commands = history
        }
        return { calc in
            if commands.count > 0 {
                for index in 0 ..< commands.count {
                    commands[index](calc)
                }
            }
        }
    }
}
