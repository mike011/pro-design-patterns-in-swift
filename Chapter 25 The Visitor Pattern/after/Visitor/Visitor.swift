import Foundation

protocol Shape {
    func accept(visitor: Visitor)
}

protocol Visitor {
    func visit(_ shape: Circle)
    func visit(_ shape: Square)
    func visit(_ shape: Rectangle)
}

class AreaVisitor: Visitor {
    var totalArea: Float = 0

    func visit(_ shape: Circle) {
        totalArea += (3.14 * powf(shape.radius, 2))
    }

    func visit(_ shape: Square) {
        totalArea += powf(shape.length, 2)
    }

    func visit(_ shape: Rectangle) {
        totalArea += (shape.xLength * shape.yLength)
    }
}

class EdgesVisitor: Visitor {
    var totalEdges = 0

    func visit(_ _: Circle) {
        totalEdges += 1
    }

    func visit(_ _: Square) {
        totalEdges += 4
    }

    func visit(_ _: Rectangle) {
        totalEdges += 4
    }
}
