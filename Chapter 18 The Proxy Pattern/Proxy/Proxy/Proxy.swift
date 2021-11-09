import Foundation

protocol HttpHeaderRequest {
    init(url: String)
    func getHeader(header: String, callback: @escaping (String, String?) -> Void)
    func execute()
}

class AccessControlProxy: HttpHeaderRequest {
    private let wrappedObject: HttpHeaderRequest

    required init(url: String) {
        wrappedObject = HttpHeaderRequestProxy(url: url)
    }

    func getHeader(header: String, callback: @escaping (String, String?) -> Void) {
        wrappedObject.getHeader(header: header, callback: callback)
    }

    func execute() {
        if UserAuthentication.shared.authenticated {
            wrappedObject.execute()
        } else {
            fatalError("Unauthorized")
        }
    }
}

private class HttpHeaderRequestProxy: HttpHeaderRequest {

    private let url: String
    private var headersRequired: [String: (String, String?) -> Void]

    required init(url: String) {
        self.url = url
        headersRequired = [String: (String, String?) -> Void]()
    }

    func getHeader(header: String, callback: @escaping (String, String?) -> Void) {
        headersRequired[header] = callback
    }

    func execute() {
        let nsUrl = URL(string: url)
        let request = URLRequest(url: nsUrl! as URL)
        URLSession.shared.dataTask(with: request as URLRequest,
                                   completionHandler: { _, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }

            let headers = httpResponse.allHeaderFields as [AnyHashable: Any]
            for (header, callback) in self.headersRequired {
                if let value = headers[header] as? String {
                    callback(header, value)
                }
            }
        }).resume()
    }
}
