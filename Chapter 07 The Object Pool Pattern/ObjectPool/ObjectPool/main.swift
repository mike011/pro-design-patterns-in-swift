import Foundation

print("Starting...")

for i in 1...20 {
    let book = Library.checkoutBook(reader: "reader #\(i)")
    if let book {
        let sleep = UInt64(arc4random()/10)
        try await Task.sleep(nanoseconds: sleep)
        if Int.random(in: 0...10) != 0 {
            Library.returnBook(book: book)
        }
    }
}

print("All blocks complete")

Library.printReport()
