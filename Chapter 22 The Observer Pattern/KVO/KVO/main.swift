import Foundation

class Subject: NSObject {
    @objc dynamic var counter = 0
}

class Observer: NSObject {
    init(subject: Subject) {
        super.init()
        subject.addObserver(self,
                            forKeyPath: "counter",
                            options: NSKeyValueObservingOptions.new,
                            context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        print("Notification: \(String(describing: keyPath)) = \(String(describing: change?[NSKeyValueChangeKey.newKey]))")
    }
}

let subject = Subject()
let observer = Observer(subject: subject)
subject.counter += 1
subject.counter = 22
