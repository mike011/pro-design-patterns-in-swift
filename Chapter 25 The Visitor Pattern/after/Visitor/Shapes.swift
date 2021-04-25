import Foundation

struct Circle: Shape {
    let radius: Float

    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}

struct Square: Shape {
    let length: Float

    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}

struct Rectangle: Shape {
    let xLength: Float
    let yLength: Float

    func accept(visitor: Visitor) {
        visitor.visit(self)
    }
}

struct ShapeCollection {
    let shapes: [Shape]

    init() {
        shapes = [
            Circle(radius: 2.5),
            Square(length: 4),
            Rectangle(xLength: 10, yLength: 2),
        ]
    }

    func accept(visitor: Visitor) {
        for shape in shapes {
            shape.accept(visitor: visitor)
        }
    }
}
