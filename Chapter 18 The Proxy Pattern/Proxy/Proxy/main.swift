import Foundation

let url = "http://www.apress.com"
let headers = ["Content-Length", "Content-Encoding"]

let proxy = AccessControlProxy(url: url)

for header in headers {
    proxy.getHeader(header: header, callback: { header, val in
        if val != nil {
            print("\(header): \(val!)")
        }
    })
}

UserAuthentication.shared.authenticate(user: "bob", pass: "secret")
proxy.execute()

// FileHandle.standardInput.availableData
