class EventBridge {
    private let outputCallback: (String, Int) -> Void

    init(callback: (String, Int) -> Void) {
        outputCallback = callback
    }

    var inputCallback: (Product) -> Void {
        return { p in self.outputCallback(p.name, p.stockLevel) }
    }
}
