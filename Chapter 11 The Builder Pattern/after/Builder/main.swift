let builder = BurgerBuilder()

// Step 1 - Ask for name
let name = "Joe"

// Step 2 - Is veggie meal required?
builder.setVeggie(choice: false)


// Step 3 - Customize burger?
builder.setMayo(choice: false)
builder.setCooked(choice: Burger.Cooked.WELLDONE)

// Step 4 - Buy additional patty?
builder.addPatty(choice: false)

let order = builder.buildObject(name: name)

order.printDescription()
