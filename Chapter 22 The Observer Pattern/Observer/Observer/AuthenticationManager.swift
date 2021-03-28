class AuthenticationManager: ShortLivedSubject {

    @discardableResult
    func authenticate(user: String, pass: String) -> Bool {
        var notificationType = NotificationTypes.authFail
        if user == "bob", pass == "secret" {
            notificationType = NotificationTypes.authSuccess
            print("User \(user) is authenticated")
        } else {
            print("Failed authentication attempt")
        }
        sendNotification(notification: Notification(type: notificationType, data: user))
        return notificationType == NotificationTypes.authSuccess
    }
}
