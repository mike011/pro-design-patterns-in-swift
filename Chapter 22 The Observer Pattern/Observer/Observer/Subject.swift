protocol Subject {
    func add(observers: Observer...)
    func removeObserver(observer: Observer)
}
