class ChangeRecord {
    private let outerTag: String
    private let productName: String
    private let catName: String
    private let innerTag: String
    private let value: String

    fileprivate init(outer: String, name: String, category: String,
                     inner: String, value: String)
    {
        outerTag = outer
        productName = name
        catName = category
        innerTag = inner
        self.value = value
    }

    var description: String {
        return "<\(outerTag)><\(innerTag) name=\"\(productName)\"" +
            " category=\"\(catName)\">\(value)</\(innerTag)></\(outerTag)>"
    }
}

class ChangeRecordBuilder {
    var outerTag: String
    var innerTag: String
    var productName: String?
    var category: String?
    var value: String?

    init() {
        outerTag = "change"
        innerTag = "product"
    }

    var changeRecord: ChangeRecord? {
        if productName != nil, category != nil, value != nil {
            return ChangeRecord(outer: outerTag, name: productName!,
                                category: category!, inner: innerTag, value: value!)
        } else {
            return nil
        }
    }
}
