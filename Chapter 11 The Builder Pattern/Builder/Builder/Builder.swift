enum Burgers {
    case STANDARD; case BIGBURGER; case SUPERVEGGIE
}

class BurgerBuilder {
    private var veggie = false
    private var pickles = false
    private var mayo = true
    private var ketchup = true
    private var lettuce = true
    private var cooked = Burger.Cooked.NORMAL
    private var patties = 2
    private var bacon = true

    private init() {
        // do nothing
    }

    func setVeggie(choice: Bool) {
        veggie = choice
        if choice {
            bacon = false
        }
    }

    func setPickles(choice: Bool) { pickles = choice }
    func setMayo(choice: Bool) { mayo = choice }
    func setKetchup(choice: Bool) { ketchup = choice }
    func setLettuce(choice: Bool) { lettuce = choice }
    func setCooked(choice: Burger.Cooked) { cooked = choice }
    func addPatty(choice: Bool) { patties = choice ? 3 : 2 }
    func setBacon(choice: Bool) { bacon = choice }

    func buildObject(name: String) -> Burger {
        return Burger(name: name, veggie: veggie, patties: patties,
                      pickles: pickles, mayo: mayo, ketchup: ketchup,
                      lettuce: lettuce, cook: cooked, bacon: bacon)
    }

    class func getBuilder(burgerType: Burgers) -> BurgerBuilder {
        var builder: BurgerBuilder
        switch burgerType {
        case .BIGBURGER: builder = BigBurgerBuilder()
        case .SUPERVEGGIE: builder = SuperVeggieBurgerBuilder()
        case .STANDARD: builder = BurgerBuilder()
        }
        return builder
    }
}

class BigBurgerBuilder: BurgerBuilder {
    override private init() {
        super.init()
        patties = 4
        bacon = false
    }

    override func addPatty(choice _: Bool) {
        fatalError("Cannot add patty to Big Burger")
    }
}

class SuperVeggieBurgerBuilder: BurgerBuilder {
    override private init() {
        super.init()
        veggie = true
        bacon = false
    }

    override func setVeggie(choice _: Bool) {
        // do nothing - always veggie
    }

    override func setBacon(choice _: Bool) {
        fatalError("Cannot add bacon to this burger")
    }
}
