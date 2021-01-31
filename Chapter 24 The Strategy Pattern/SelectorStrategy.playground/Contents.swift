import Foundation

class City {
    let name: String

    init(_ name: String) {
        self.name = name
    }

    func compareTo(other: City) -> ComparisonResult {
        if name == other.name {
            return ComparisonResult.orderedSame
        } else if name < other.name {
            return ComparisonResult.orderedDescending
        } else {
            return ComparisonResult.orderedAscending
        }
    }
}

let nsArray = NSArray(array: [City("London"), City("New York"),
                              City("Paris"), City("Rome")])
let sorted = nsArray.sortedArray(using: Selector(("compareTo:")))

for city in sorted {
    print((city as! City).name)
}
