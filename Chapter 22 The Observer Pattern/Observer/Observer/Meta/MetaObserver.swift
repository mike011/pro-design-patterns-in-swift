protocol MetaObserver: Observer {
    func notifySubjectCreated(subject: Subject)
    func notifySubjectDestroyed(subject: Subject)
}
