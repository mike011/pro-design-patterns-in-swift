// create meta observer
let monitor = AttackMonitor()
MetaSubject.shared.add(observers: monitor)

// create regular observers
let log = ActivityLog()
let cache = FileCache()

let authM = AuthenticationManager()
// register only the regular observers
authM.add(observers: cache, monitor)

authM.authenticate(user: "bob", pass: "secret")
print("-----")
authM.authenticate(user: "joe", pass: "shhh")
