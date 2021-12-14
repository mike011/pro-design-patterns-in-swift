func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.col == rhs.col && lhs.row == rhs.row
}

class Coordinate: Hashable, CustomStringConvertible {
    let col: Character
    let row: Int

    init(col: Character, row: Int) {
        self.col = col; self.row = row
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(description.hashValue)
    }

    var description: String {
        return "\(col)(\row)"
    }
}

class Cell {
    var coordinate: Coordinate
    var value: Int

    init(col: Character, row: Int, val: Int) {
        coordinate = Coordinate(col: col, row: row)
        value = val
    }
}

class Spreadsheet {
    var grid: Flyweight

    init() {
        grid = FlyweightFactory.createFlyweight()
    }

    func setValue(coord: Coordinate, value: Int) {
        grid[coord] = value
    }

    var total: Int {
        return grid.total
    }
}
