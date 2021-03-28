import Foundation

protocol Observer: class {
    func notify(notification: Notification)
}
