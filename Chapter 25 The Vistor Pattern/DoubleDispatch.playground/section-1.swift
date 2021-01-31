
protocol MyProtocol {
    func dispatch(handler: Handler)
}

class FirstClass: MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(self)
    }
}

class SecondClass: MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(self)
    }
}

class Handler {
    func handle(arg _: MyProtocol) {
        println("Protocol")
    }

    func handle(arg _: FirstClass) {
        println("First Class")
    }

    func handle(arg _: SecondClass) {
        println("Second Class")
    }
}

let objects: [MyProtocol] = [FirstClass(), SecondClass()]
let handler = Handler()

for object in objects {
    object.dispatch(handler)
    // handler.handle(object);
}
