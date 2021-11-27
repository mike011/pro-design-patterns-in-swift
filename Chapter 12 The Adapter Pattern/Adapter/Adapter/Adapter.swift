class NewCoDirectoryAdapter: EmployeeDataSource {
    private let directory: NewCoDirectory

    init() {
        directory = NewCoDirectory()
    }

    var employees: [Employee] {
        return directory.getStaff().values.map { sv -> Employee in
            Employee(name: sv.getName(), title: sv.getJob())
        }
    }

    func search(byName: String) -> [Employee] {
        return createEmployees(filter: { (sv: NewCoStaffMember) -> Bool in
            sv.getName().range(of: byName) != nil
        })
    }

    func search(byTitle: String) -> [Employee] {
        return createEmployees(filter: { (sv: NewCoStaffMember) -> Bool in
            sv.getJob().range(of: byTitle) != nil
        })
    }

    private func createEmployees(filter filterClosure: (NewCoStaffMember) -> Bool)
        -> [Employee]
    {
        return directory.getStaff().values.filter { newCoStaffMember in
            filterClosure(newCoStaffMember)
        }.map { entry in
            Employee(name: entry.getName(), title: entry.getJob())
        }
    }
}
