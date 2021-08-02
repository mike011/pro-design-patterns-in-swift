import Foundation

var queue = DispatchQueue(label: "workQ",
                          qos: .userInitiated,
                          attributes: .concurrent,
                          autoreleaseFrequency: .inherit,
                          target: nil)
var group = DispatchGroup()

print("Starting...")

for i in 1 ... 20 {
    queue.async(group: group) {
        let book = Library.checkoutBook(reader: "reader #\(i)")
        if let book = book {
            let sleep = Double(arc4random() % 2)
            Thread.sleep(forTimeInterval: sleep)
            Library.returnBook(book: book)
        }
    }
}
group.wait()

print("All blocks complete")

Library.printReport()
