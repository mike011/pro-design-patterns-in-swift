import Foundation

struct Circle {
    let radius: Float
}

struct Square {
    let length: Float
}

struct Rectangle {
    let xLength: Float
    let yLength: Float
}

class ShapeCollection {
    let shapes: [Any]

    init() {
        shapes = [
            Circle(radius: 2.5),
            Square(length: 4),
            Rectangle(xLength: 10, yLength: 2),
        ]
    }

    func calculateAreas() -> Float {
        return shapes.reduce(0, {total, shape in
            if let circle = shape as? Circle {
                print("Found Circle")
                return total + (3.14 * powf(circle.radius, 2))
            } else if let square = shape as? Square {
                print("Found Square")
                return total + powf(square.length, 2)
            } else if let rect = shape as? Rectangle {
                print("Found Rectangle")
                return total + (rect.xLength * rect.yLength)
            } else {
                // unknown type - do nothing
                return total
            }
        })
    }

    func countEdges() -> Int {
        return shapes.reduce(0, {total, shape in
            if let _ = shape as? Circle {
                print("Found Circle")
                return total + 1
            } else if let _ = shape as? Square {
                print("Found Square")
                return total + 4
            } else if let _ = shape as? Rectangle {
                print("Found Rectangle")
                return total + 4
            } else {
                // unknown type - do nothing
                return total
            }
        });
    }
}
