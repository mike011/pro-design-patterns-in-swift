class Notification {
    let type: NotificationTypes
    let data: Any?

    init(type: NotificationTypes, data: Any?) {
        self.type = type
        self.data = data
    }
}
