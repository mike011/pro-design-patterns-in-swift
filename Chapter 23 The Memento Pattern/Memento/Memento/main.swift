let ledger = Ledger()

ledger.addEntry(counterParty: "Bob", amount: 100.43)
ledger.addEntry(counterParty: "Joe", amount: 200.20)


let memento = ledger.createMemento()

ledger.addEntry(counterParty: "Alice", amount: 500)
ledger.addEntry(counterParty: "Tony", amount: 20)

ledger.printEntries()

ledger.applyMemento(memento: memento)

ledger.printEntries()
