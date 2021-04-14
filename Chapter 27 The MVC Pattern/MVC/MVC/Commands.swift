import Foundation

enum Command: String, CaseIterable {
    case listPeople = "L: List People"
    case addPerson = "A: Add Person"
    case deletePerson = "D: Delete Person"
    case updatePerson = "U: Update Person"
    case search = "S: Search"
    case listCities = "LC: List Cities"
    case searchCities = "SC: Search Cities"
    case deleteCity = "DC: Delete City"
    case quit = "Q: Exit the App"

    static func getFromInput(input: String) -> Command? {
        switch input.lowercased() {
        case "l":
            return .listPeople
        case "a":
            return .addPerson
        case "d":
            return .deletePerson
        case "u":
            return .updatePerson
        case "s":
            return .search
        case "lc":
            return .listCities
        case "sc":
            return .searchCities
        case "dc":
            return .deleteCity
        case "q":
            return .quit
        default:
            return nil
        }
    }
}
