import Foundation

class Product: NSObject, @unchecked Sendable, NSCopying {

    private(set) var name: String
    private(set) var productDescription: String
    private(set) var category: String
    private var stockLevelBackingValue: Int = 0
    private var priceBackingValue: Double = 0

    init(name: String, description: String, category: String, price: Double,
         stockLevel: Int)
    {
        self.name = name
        productDescription = description
        self.category = category

        super.init()

        self.price = price
        self.stockLevel = stockLevel
    }

    var stockLevel: Int {
        get { return stockLevelBackingValue }
        set { stockLevelBackingValue = max(0, newValue) }
    }

    private(set) var price: Double {
        get { return priceBackingValue }
        set { priceBackingValue = max(1, newValue) }
    }

    var stockValue: Double {
        return price * Double(stockLevel)
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: name, description: description,
                       category: category, price: price,
                       stockLevel: stockLevel)
    }
}
