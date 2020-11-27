import Foundation

@objc class Book: PoolItem {
    let author: String
    let title: String
    let stockNumber: Int
    var reader: String?
    var checkoutCount = 0

    init(author: String, title: String, stock: Int) {
        self.author = author
        self.title = title
        stockNumber = stock
    }

    var canReuse: Bool {
        let reusable = checkoutCount < 5
        if !reusable {
            println("Eject: Book#\(stockNumber)")
        }
        return reusable
    }
}
