import Foundation

private class WeakObserverReference {
    weak var observer: Observer?

    init(observer: Observer) {
        self.observer = observer
    }
}

class SubjectBase: Subject {
    private var observers = [WeakObserverReference]()
    private var collectionQueue = DispatchQueue(label: "colQ",
                                                qos: .background,
                                                attributes: .concurrent,
                                                autoreleaseFrequency: .inherit,
                                                target: nil)

    func add(observers: Observer...) {
        collectionQueue.sync {
            for newOb in observers {
                self.observers.append(WeakObserverReference(observer: newOb))
            }
        }
    }

    func removeObserver(observer: Observer) {
        collectionQueue.sync {
            self.observers = observers.filter() { weakref in
                weakref.observer != nil && weakref.observer !== observer
            }
        }
    }

    func sendNotification(notification: Notification) {
        collectionQueue.sync() { () in
            for ob in self.observers {
                ob.observer?.notify(notification: notification)
            }
        }
    }
}
