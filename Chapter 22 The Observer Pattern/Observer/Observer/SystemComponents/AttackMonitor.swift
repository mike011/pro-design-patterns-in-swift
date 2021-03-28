class AttackMonitor: MetaObserver {

    func notifySubjectCreated(subject: Subject) {
        if subject is AuthenticationManager {
            subject.add(observers: self)
        }
    }

    func notifySubjectDestroyed(subject: Subject) {
        subject.removeObserver(observer: self)
    }

    func notify(notification: Notification) {
        monitorSuspiciousActivity
            = (notification.type == NotificationTypes.authFail)
    }

    var monitorSuspiciousActivity: Bool = false {
        didSet {
            print("Monitoring for attack: \(monitorSuspiciousActivity)")
        }
    }
}
