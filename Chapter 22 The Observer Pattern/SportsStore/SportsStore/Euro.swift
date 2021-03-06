class EuroHandler {
    func getDisplayString(amount: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: amount)
        return "€\(formatted.dropFirst())"
    }

    func getCurrencyAmount(amount: Double) -> Double {
        return 0.76164 * amount
    }
}
