// Step 1 - Ask for name
let name = "Joe"

// Step 2 - Is veggie meal required?
let veggie = false

// Step 3 - Customize burger?
let pickles = true
let mayo = false
let ketchup = true
let lettuce = true
let cooked = Burger.Cooked.NORMAL

// Step 4 - Buy additional patty?
let patties = 2

let order = Burger(name: name, veggie: veggie, patties: patties, pickles: pickles, mayo: mayo, ketchup: ketchup, lettuce: lettuce, cook: cooked)

order.printDescription()
