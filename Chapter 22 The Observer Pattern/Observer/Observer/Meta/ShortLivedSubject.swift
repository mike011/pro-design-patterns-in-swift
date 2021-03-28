class ShortLivedSubject: SubjectBase {
    override init() {
        super.init()
        MetaSubject.shared.notifySubjectCreated(subject: self)
    }

    deinit {
        MetaSubject.shared.notifySubjectDestroyed(subject: self)
    }
}
