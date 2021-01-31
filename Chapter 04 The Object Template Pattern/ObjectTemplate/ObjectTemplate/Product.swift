class Product {
    var name: String
    var price: Double
    private var stockBackingValue: Int = 0

    var stock: Int {
        get {
            return stockBackingValue
        }
        set {
            stockBackingValue = max(0, newValue)
        }
    }

    init(name: String, price: Double, stock: Int) {
        self.name = name
        self.price = price
        self.stock = stock
    }

    func calculateTax(rate: Double) -> Double {
        return min(10, price * rate)
    }

    var stockValue: Double {
        return price * Double(stock)
    }
}
