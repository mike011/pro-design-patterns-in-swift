struct Employee {
    var name: String
    var title: String
}

protocol EmployeeDataSource {
    var employees: [Employee] { get }
    func search(byName: String) -> [Employee]
    func search(byTitle: String) -> [Employee]
}
