import Foundation

class LedgerEntry {
    let id: Int
    let counterParty: String
    let amount: Float

    init(id: Int, counterParty: String, amount: Float) {
        self.id = id
        self.counterParty = counterParty
        self.amount = amount
    }
}

class LedgerMemento: Memento {
    let data: NSData

    init(data: NSData) { self.data = data }
}

class Ledger: NSObject, Originator, NSCoding {

    private var entries = [Int: LedgerEntry]()
    private var nextId = 1
    var total: Float = 0

    override init() {
        // do nothing - required to allow instances
        // to be created without a coder
    }

    required init(coder aDecoder: NSCoder) {
        total = aDecoder.decodeFloat(forKey: "total")
        nextId = aDecoder.decodeInteger(forKey: "nextId")
        entries.removeAll(keepingCapacity: true)
        if let entryArray = aDecoder.decodeData()
            as AnyObject? as? [NSDictionary]
        {
            for entryDict in entryArray {
                let id = entryDict["id"] as! Int
                let counterParty = entryDict["counterParty"] as! String
                let amount = entryDict["amount"] as! Float
                entries[id] = LedgerEntry(id: id, counterParty: counterParty,
                                          amount: amount)
            }
        }
    }

    func encode(with coder: NSCoder) {
        coder.encode(total, forKey: "total")
        coder.encode(nextId, forKey: "nextId")
        var entriesArray = [NSMutableDictionary]()
        for entry in entries.values {
            let dict = NSMutableDictionary()
            dict["id"] = entry.id
            dict["counterParty"] = entry.counterParty
            dict["amount"] = entry.amount
            entriesArray.append(dict)
        }
        coder.encode(entriesArray)
    }

    func createMemento() -> Memento {
        return LedgerMemento(data: NSKeyedArchiver.archivedData(withRootObject: self) as NSData)
    }

    func applyMemento(memento: Memento) {
        if let memento = memento as? LedgerMemento {
            if let obj = NSKeyedUnarchiver.unarchiveObject(with: memento.data as Data)
                as? Ledger
            {
                total = obj.total
                nextId = obj.nextId
                entries = obj.entries
            }
        }
    }

    func addEntry(counterParty: String, amount: Float) {
        let entry = LedgerEntry(id: nextId, counterParty: counterParty, amount: amount)
        nextId += 1
        entries[entry.id] = entry
        total += amount
    }

    func printEntries() {
        for id in entries.keys.sorted(by: <) {
            if let entry = entries[id] {
                print("#\(id): \(entry.counterParty) $\(entry.amount)")
            }
        }
        print("Total: $\(total)")
        print("----")
    }
}
