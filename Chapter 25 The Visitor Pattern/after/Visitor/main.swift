let shapes = ShapeCollection()
let areaVisitor = AreaVisitor()
shapes.accept(visitor: areaVisitor)
print("Area: \(areaVisitor.totalArea)")
print("---")

let edgeVisitor = EdgesVisitor()
shapes.accept(visitor: edgeVisitor)
print("Edges: \(edgeVisitor.totalEdges)")
