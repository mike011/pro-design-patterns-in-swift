class ActivityLog: Observer {

    func notify(notification: Notification) {
        print("Auth request for \(notification.type.rawValue) "
            + "Success: \(notification.data!)")
    }

    func logActivity(activity: String) {
        print("Log: \(activity)")
    }
}
