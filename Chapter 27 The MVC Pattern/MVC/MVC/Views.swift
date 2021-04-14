protocol View {
    var exit: Bool {get set}
    func execute()
}

class PersonListView: View {

    var exit = false
    private let people: [Person]

    init(data: [Person]) {
        people = data
    }

    func execute() {
        for person in people {
            print(person)
        }
    }
}

class CityListView: View {
    
    var exit = false
    private let cities: [String]

    init(data: [String]) {
        cities = data
    }

    func execute() {
        for city in cities {
            print("City: \(city)")
        }
    }
}

class QuitView: View {
    var exit = true

    func execute() {
        print("Thank You")
    }


}
