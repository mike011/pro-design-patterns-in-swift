import Foundation

class Person: NSObject, NSCopying {

    var name: String
    var country: String

    init(name: String, country: String) {
        self.name = name
        self.country = country
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Person(name: name, country: country)
    }
}

var people = [Person(name: "Joe", country: "France"),
              Person(name: "Bob", country: "USA")]
var otherpeople = people

people[0].country = "UK"
print("Country: \(otherpeople[0].country)")
