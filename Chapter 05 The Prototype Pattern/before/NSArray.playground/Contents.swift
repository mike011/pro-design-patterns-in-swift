import Foundation

class Person: NSObject, NSCopying {
    var name: String
    var country: String

    init(name: String, country: String) {
        self.name = name; self.country = country
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Person(name: name, country: country)
    }
}

var data = NSMutableArray(objects: 10, "iOS", Person(name: "Joe", country: "USA"))
var copiedData = data

data[0] = 20
data[1] = "MacOS"
(data[2] as! Person).name = "Alice"

print("Identity: \(data === copiedData)")
print("0: \(copiedData[0]) 1: \(copiedData[1]) 2: \((copiedData[2] as! Person).name)")
