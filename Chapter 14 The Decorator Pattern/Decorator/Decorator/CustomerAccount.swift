import Foundation

class CustomerAccount: CustomStringConvertible {


    let customerName: String
    var purchases = [Purchase]()

    init(name: String) {
        customerName = name
    }

    func addPurchase(purchase: Purchase) {
        purchases.append(purchase)
    }

    var description: String {
        var result = ""
        var total: Float = 0
        for p in purchases {
            total += p.totalPrice
            result += "Purchase \(p), Price \(formatCurrencyString(number: p.totalPrice))\n"
        }
        result += "Total due: \(formatCurrencyString(number: total))"
        return result
    }

    func formatCurrencyString(number: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
