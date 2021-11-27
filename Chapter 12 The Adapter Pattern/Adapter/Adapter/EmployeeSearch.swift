class SearchTool {
    enum SearchType {
        case name
        case title
    }

    private let sources: [EmployeeDataSource]

    init(dataSources: EmployeeDataSource...) {
        sources = dataSources
    }

    var employees: [Employee] {
        var results = [Employee]()
        for source in sources {
            results += source.employees
        }
        return results
    }

    func search(text: String, type: SearchType) -> [Employee] {
        var results = [Employee]()
        for source in sources {
            switch type {
            case .name:
                results += source.search(byName: text)
            case .title:
                results += source.search(byTitle: text)
            }
        }
        return results
    }
}
