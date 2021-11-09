class UserAuthentication {
    var user: String?
    var authenticated: Bool = false

    private init() {
        // do nothing - stops instances being created
    }

    func authenticate(user: String, pass: String) {
        if pass == "secret" {
            self.user = user
            authenticated = true
        } else {
            self.user = nil
            authenticated = false
        }
    }

    class var shared: UserAuthentication {
        enum singletonWrapper {
            static let singleton = UserAuthentication()
        }
        return singletonWrapper.singleton
    }
}
