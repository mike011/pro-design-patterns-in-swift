import Foundation

let globalLogger = Logger()

final class Logger {
    private var data = [String]()
    private let arrayQ = DispatchQueue(label: "arrayQ")

    fileprivate init() {
        // do nothing - required to stop instances being
        // created by code in other files
    }

    func log(msg: String) {
        arrayQ.sync() { () in
            self.data.append(msg)
        }
    }

    func printLog() {
        for msg in data {
            print("Log: \(msg)")
        }
    }
}
