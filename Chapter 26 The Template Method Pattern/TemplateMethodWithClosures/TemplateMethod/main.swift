let donorDb = DonorDatabase()

let galaInvitations = donorDb.generate(maxNumber: 2)
for invite in galaInvitations {
    print(invite)
}

class NewDonors: DonorDatabase {
    override init() {
        super.init()
        filter = { $0.filter({$0.lastDonation == 0})};
        generate = { $0.map({ "Hi \($0.firstName)"})};
    }
}

let newDonor = NewDonors()
for invite in newDonor.generate(maxNumber: Int.max) {
    print(invite)
}
