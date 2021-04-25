
protocol MyProtocol {
    func dispatch(handler: Handler)
}

class FirstClass: MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(arg: self)
    }
}

class SecondClass: MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(arg: self)
    }
}

class Handler {
    func handle(arg _: MyProtocol) {
        print("Protocol")
    }

    func handle(arg _: FirstClass) {
        print("First Class")
    }

    func handle(arg _: SecondClass) {
        print("Second Class")
    }
}

let objects: [MyProtocol] = [FirstClass(), SecondClass()]
let handler = Handler()

for object in objects {
    object.dispatch(handler: handler)
    //handler.handle(object);
}
