import Foundation

@MainActor
final class Library {
    private var books: [Book]
    private let pool: Pool<Book>

    private init(stockLevel: Int) {
        books = [Book]()
        for count in 1...stockLevel {
            books.append(Book(author: "Dickens, Charles",
                              title: "Hard Times",
                              stock: count))
        }
        pool = Pool<Book>(items: books)
    }

    private class var singleton: Library {
        enum SingletonWrapper {
            @MainActor
            static let singleton = Library(stockLevel: 3)
        }
        return SingletonWrapper.singleton
    }

    class func checkoutBook(reader: String) -> Book? {
        let book = singleton.pool.getFromPool()
        book?.reader = reader
        book?.checkoutCount += 1
        return book
    }

    class func returnBook(book: Book) {
        book.reader = nil
        singleton.pool.returnToPool(item: book)
    }

    class func printReport() {
        for book in singleton.books {
            print("...Book #\(book.stockNumber)...")
            print("Checked out \(book.checkoutCount) times")
            if let reader = book.reader {
                print("Checked out to \(reader)")
            } else {
                print("In stock")
            }
        }
    }
}
