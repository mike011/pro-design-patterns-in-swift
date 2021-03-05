import Foundation

class StockTotalFactory {
    enum Currency {
        case USD
        case GBP
    }

    fileprivate(set) var formatter: StockValueFormatter?
    fileprivate(set) var converter: StockValueConverter?

    class func getFactory(curr: Currency) -> StockTotalFactory {
        if curr == Currency.USD {
            return DollarStockTotalFactory.sharedInstance
        } else {
            return PoundStockTotalFactory.sharedInstance
        }
    }
}

private class DollarStockTotalFactory: StockTotalFactory {
    override private init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter()
    }

    class var sharedInstance: StockTotalFactory {
        enum SingletonWrapper {
            static let singleton = DollarStockTotalFactory()
        }
        return SingletonWrapper.singleton
    }
}

private class PoundStockTotalFactory: StockTotalFactory {
    override private init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }

    class var sharedInstance: StockTotalFactory {
        enum SingletonWrapper {
            static let singleton = PoundStockTotalFactory()
        }
        return SingletonWrapper.singleton
    }
}
