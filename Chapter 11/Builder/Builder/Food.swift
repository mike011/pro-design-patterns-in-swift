class Burger {
    let customerName: String
    let veggieProduct: Bool
    let patties: Int
    let pickles: Bool
    let mayo: Bool
    let ketchup: Bool
    let lettuce: Bool
    let cook: Cooked
    let bacon: Bool

    enum Cooked: String {
        case RARE = "Rare"
        case NORMAL = "Normal"
        case WELLDONE = "Well Done"
    }

    init(name: String, veggie: Bool, patties: Int, pickles: Bool, mayo: Bool,
         ketchup: Bool, lettuce: Bool, cook: Cooked, bacon: Bool)
    {
        customerName = name
        veggieProduct = veggie
        self.patties = patties
        self.pickles = pickles
        self.mayo = mayo
        self.ketchup = ketchup
        self.lettuce = lettuce
        self.cook = cook
        self.bacon = bacon
    }

    func printDescription() {
        println("Name \(customerName)")
        println("Veggie: \(veggieProduct)")
        println("Patties: \(patties)")
        println("Pickles: \(pickles)")
        println("Mayo: \(mayo)")
        println("Ketchup: \(ketchup)")
        println("Lettuce: \(lettuce)")
        println("Cook: \(cook.rawValue)")
        println("Bacon: \(bacon)")
    }
}
