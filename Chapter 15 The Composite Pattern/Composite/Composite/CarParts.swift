protocol CarPart {
    var name: String { get }
    var price: Float { get }

    func addPart(part: CarPart) -> Void
    func removePart(part: CarPart) -> Void
}

class Part: CarPart {
    let name: String
    let price: Float

    init(name: String, price: Float) {
        self.name = name; self.price = price
    }

    func addPart(part _: CarPart) {
        // do nothing
    }

    func removePart(part _: CarPart) {
        // do nothing
    }
}

class CompositePart: CarPart {
    let name: String
    private var parts: [CarPart]

    init(name: String, parts: CarPart...) {
        self.name = name; self.parts = parts
    }

    var price: Float {
        return parts.reduce(0) { subtotal, part in
            subtotal + part.price
        }
    }

    func addPart(part: CarPart) {
        parts.append(part)
    }

    func removePart(part: CarPart) {
        for index in 0 ..< parts.count {
            if parts[index].name == part.name {
                parts.remove(at: index)
                break
            }
        }
    }
}
