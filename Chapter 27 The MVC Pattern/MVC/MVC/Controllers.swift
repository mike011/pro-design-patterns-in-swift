struct Chain {
    static func create(fromRepository repository: Repository) -> ControllerBase {
        let global = GlobalController(repo: repository, nextController: nil)
        let city = CityController(repo: repository, nextController: global)
        let chain = PersonController(repo: repository, nextController: city)
        return chain
    }
}

class ControllerBase {
    fileprivate let repository: Repository
    private let nextController: ControllerBase?

    init(repo: Repository, nextController: ControllerBase?) {
        repository = repo
        self.nextController = nextController
    }

    func handleCommand(command: Command, data: [String]) -> View? {
        return nextController?.handleCommand(command: command, data: data)
    }
}

class PersonController: ControllerBase {
    override func handleCommand(command: Command, data: [String]) -> View? {
        switch command {
        case .listPeople:
            return listAll()
        case .addPerson:
            return addPerson(name: data[0], city: data[1])
        case .deletePerson:
            return deletePerson(name: data[0])
        case .updatePerson:
            return updatePerson(name: data[0], newCity: data[1])
        case .search:
            return search(term: data[0])
        default:
            return super.handleCommand(command: command, data: data)
        }
    }

    private func listAll() -> View {
        return PersonListView(data: repository.People)
    }

    private func addPerson(name: String, city: String) -> View {
        repository.addPerson(person: Person(name, city))
        return listAll()
    }

    private func deletePerson(name: String) -> View {
        repository.removePerson(name: name)
        return listAll()
    }

    private func updatePerson(name: String, newCity: String) -> View {
        repository.updatePerson(name: name, newCity: newCity)
        return listAll()
    }

    private func search(term: String) -> View {
        let termLower = term.lowercased()
        let matches = repository.People.filter { person in
            person.name.lowercased().range(of: termLower) != nil
                || person.city.lowercased().range(of: termLower) != nil
        }
        return PersonListView(data: matches)
    }
}

class CityController: ControllerBase {
    override func handleCommand(command: Command, data: [String]) -> View? {
        switch command {
        case .listCities:
            return listAll()
        case .searchCities:
            return search(city: data[0])
        case .deleteCity:
            return delete(city: data.joined(separator: " "))
        default:
            return super.handleCommand(command: command, data: data)
        }
    }

    private func listAll() -> View {
        return CityListView(data: repository.People.map { $0.city }.unique())
    }

    private func search(city: String) -> View {
        let cityLower = city.lowercased()
        let matches: [Person] = repository.People
            .filter { $0.city.lowercased() == cityLower }
        return PersonListView(data: matches)
    }

    private func delete(city: String) -> View {
        let cityLower = city.lowercased()
        let toDelete = repository.People
            .filter { $0.city.lowercased() == cityLower }
        for person in toDelete {
            repository.removePerson(name: person.name)
        }
        return PersonListView(data: repository.People)
    }
}

class GlobalController: ControllerBase {
    override func handleCommand(command: Command, data: [String]) -> View? {
        switch command {
        case .quit:
            return quit()
        default:
            return super.handleCommand(command: command, data: data)
        }
    }

    private func quit() -> View {
        return QuitView()
    }
}
