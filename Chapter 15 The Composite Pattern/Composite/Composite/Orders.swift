import Foundation

class CustomerOrder {
    let customer: String
    let parts: [CarPart]

    init(customer: String, parts: [CarPart]) {
        self.customer = customer
        self.parts = parts
    }

    var totalPrice: Float {
        return parts.reduce(0) { subtotal, part in
            subtotal + part.price
        }
    }

    func printDetails() {
        print("Order for \(customer): Cost: \(formatCurrencyString(number: totalPrice))")
    }

    func formatCurrencyString(number: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
