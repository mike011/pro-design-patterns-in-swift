import Foundation

class Circle: Shape {
    let radius: Float

    init(radius: Float) {
        self.radius = radius
    }

    func accept(visitor: Visitor) {
        visitor.visit(shape: self)
    }
}

class Square: Shape {
    let length: Float

    init(length: Float) {
        self.length = length
    }

    func accept(visitor: Visitor) {
        visitor.visit(shape: self)
    }
}

class Rectangle: Shape {
    let xLen: Float
    let yLen: Float

    init(x: Float, y: Float) {
        xLen = x
        yLen = y
    }

    func accept(visitor: Visitor) {
        visitor.visit(shape: self)
    }
}

class ShapeCollection {
    let shapes: [Shape]

    init() {
        shapes = [
            Circle(radius: 2.5),
            Square(length: 4),
            Rectangle(x: 10, y: 2),
        ]
    }

    func accept(visitor: Visitor) {
        for shape in shapes {
            shape.accept(visitor: visitor)
        }
    }
}
