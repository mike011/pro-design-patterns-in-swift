protocol View {
    func execute()
}

class PersonListView: View {
    private let people: [Person]

    init(data: [Person]) {
        people = data
    }

    func execute() {
        for person in people {
            println(person)
        }
    }
}

class CityListView: View {
    private let cities: [String]

    init(data: [String]) {
        cities = data
    }

    func execute() {
        for city in cities {
            println("City: \(city)")
        }
    }
}
