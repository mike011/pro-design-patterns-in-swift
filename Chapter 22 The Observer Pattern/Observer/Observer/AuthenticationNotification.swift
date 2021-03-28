class AuthenticationNotification: Notification {

    init(user: String, success: Bool) {
        super.init(type: success ? NotificationTypes.authSuccess
            : NotificationTypes.authFail, data: user)
    }

    var userName: String? {
        return data as! String?
    }

    var requestSuccessed: Bool {
        return type == NotificationTypes.authSuccess
    }
}
