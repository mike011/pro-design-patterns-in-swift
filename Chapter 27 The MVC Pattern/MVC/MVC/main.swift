import Foundation

class Main {
    private let controllerChain = Chain.create(fromRepository: MemoryRepository())

    private var stdIn = FileHandle.standardInput
    private var command = Command.listPeople
    private var data = [String]()

    func go() {
        while handleCommand() {
            readInput()
        }
    }

    fileprivate func handleCommand() -> Bool {
        if let view = controllerChain.handleCommand(command: command, data: data) {
            view.execute()

            if view.exit {
                return false
            }
            print("--Commands--")
            for command in Command.allCases {
                print(command.rawValue)
            }
        } else {
            fatalError("No view")
        }
        return true
    }

    fileprivate func readInput() {
        let input = String(data: stdIn.availableData,
                           encoding: String.Encoding.utf8) ?? ""

        let inputArray = input.split()

        if inputArray.count > 0 {
            command = Command.getFromInput(input: inputArray.first!) ?? Command.listPeople
            if inputArray.count > 1 {
                data = Array(inputArray[1...inputArray.count - 1])
            } else {
                data = []
            }
        }
        print("Command \(command.rawValue) Data \(data)")
    }
}

Main().go()
