class FileCache: Observer {

    func notify(notification: Notification) {
        if let authNotification = notification as? AuthenticationNotification {
            if authNotification.requestSuccessed,
               authNotification.userName != nil
            {
                loadFiles(user: authNotification.userName!)
            }
        }
    }

    func loadFiles(user: String) {
        print("Load files for \(user)")
    }
}
