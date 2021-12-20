let account = CustomerAccount(name: "Joe")

account.addPurchase(purchase: Purchase(product: "Red Hat", price: 10))
account.addPurchase(purchase: Purchase(product: "Scarf", price: 20))
account.addPurchase(purchase: EndOfLineDecorator(purchase: BlackFridayDecorator(purchase:
    GiftOptionDecorator(purchase: Purchase(product: "Sunglasses", price: 25),
                        options: .giftWrap, .delivery))))

print(account)

for p in account.purchases {
    if let d = p as? DiscountDecorator {
        print("\(p) has \(d.countDiscounts()) discounts")
    } else {
        print("\(p) has no discounts")
    }
}
