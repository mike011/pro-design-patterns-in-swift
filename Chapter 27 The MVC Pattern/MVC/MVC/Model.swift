import Foundation

func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name && lhs.city == rhs.city
}

class Person: Equatable, CustomStringConvertible {
    var name: String
    var city: String

    init(_ name: String, _ city: String) {
        self.name = name
        self.city = city
    }

    var description: String {
        return "Name: \(name), City: \(city)"
    }
}

protocol Repository {
    var People: [Person] { get }

    func addPerson(person: Person)
    func removePerson(name: String)
    func updatePerson(name: String, newCity: String)
}

class MemoryRepository: Repository {
    private var peopleArray: [Person]

    init() {
        peopleArray = [
            Person("Bob", "New York"),
            Person("Alice", "London"),
            Person("Joe", "Paris"),
        ]
    }

    var People: [Person] {
        return peopleArray
    }

    func addPerson(person: Person) {
        peopleArray.append(person)
    }

    func removePerson(name: String) {
        let nameLower = name.lowercased()
        peopleArray = peopleArray
            .filter { $0.name.lowercased() != nameLower }
    }

    func updatePerson(name: String, newCity: String) {
        let nameLower = name.lowercased()
        let test: ((Person) -> Bool) = {
            p in p.name.lowercased() == nameLower
        }

        if let person = peopleArray.first(where: test) {
            person.city = newCity
        }
    }
}
