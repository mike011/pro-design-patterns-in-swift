class MetaSubject: SubjectBase, MetaObserver {
    func notifySubjectCreated(subject: Subject) {
        let created = Notification(type: .subjectCreated,
                                   data: subject)
        sendNotification(notification: created)
    }

    func notifySubjectDestroyed(subject: Subject) {
        let destroyed = Notification(type: .subjectDestroyed,
                                    data: subject)
        sendNotification(notification: destroyed)
    }

    class var shared: MetaSubject {
        enum singletonWrapper {
            static let singleton = MetaSubject()
        }
        return singletonWrapper.singleton
    }

    func notify(notification _: Notification) {
        // do nothing - required for Observer conformance
    }
}
