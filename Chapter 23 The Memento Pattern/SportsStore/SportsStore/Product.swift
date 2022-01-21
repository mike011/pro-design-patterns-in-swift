import Foundation

class Product: NSObject, NSCopying {

    private(set) var name: String
    private(set) var productDescription: String
    private(set) var category: String
    private var stockLevelBackingValue = 0
    private var priceBackingValue = 0.0

    required init(name: String, description: String, category: String, price: Double,
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
        set {
            stockLevelBackingValue = max(0, newValue)
            let name = NSNotification.Name(rawValue: "stockUpdate")
            NotificationCenter.default.post(name: name, object: self)
        }
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

    class func createProduct(name: String, description: String, category: String,
                             price: Double, stockLevel: Int) -> Product
    {
        return Product(name: name, description: description, category: category,
                       price: price, stockLevel: stockLevel)
    }
}

class ProductComposite: Product {
    private let products: [Product]

    required init(name _: String, description _: String, category _: String,
                  price _: Double, stockLevel _: Int)
    {
        fatalError("Not implemented")
    }

    init(name: String, description: String, category: String, stockLevel: Int,
         products: Product...)
    {
        self.products = products
        super.init(name: name, description: description, category: category,
                   price: 0, stockLevel: stockLevel)
    }

    override var price: Double {
        get { return products.reduce(0) { total, p in total + p.price } }
        set { /* do nothing */ }
    }
}
