class PriceDecorator: Product {
    private let wrappedProduct: Product

    required init(name _: String, description _: String, category _: String,
                  price _: Double, stockLevel _: Int)
    {
        fatalError("Not supported")
    }

    init(product: Product) {
        wrappedProduct = product
        super.init(name: product.name, description: product.productDescription,
                   category: product.category, price: product.price,
                   stockLevel: product.stockLevel)
    }
}

class LowStockIncreaseDecorator: PriceDecorator {
    override var price: Double {
        var price = wrappedProduct.price
        if stockLevel <= 4 {
            price = price * 1.5
        }
        return price
    }
}

class SoccerDecreaseDecorator: PriceDecorator {
    override var price: Double {
        return super.wrappedProduct.price * 0.5
    }
}
