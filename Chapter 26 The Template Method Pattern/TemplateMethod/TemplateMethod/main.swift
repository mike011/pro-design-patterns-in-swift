let donorDb = DonorDatabase()

let galaInvitations = donorDb.generate(maxNumber: 2)
for invite in galaInvitations {
    print(invite)
}

class NewDonors: DonorDatabase {
    override func filter(donors: [Donor]) -> [Donor] {
        return donors.filter { $0.lastDonation == 0 }
    }

    override func generate(donors: [Donor]) -> [String] {
        return donors.map { "Hi \($0.firstName)" }
    }
}

let newDonor = NewDonors()
for invite in newDonor.generate(maxNumber: Int.max) {
    print(invite)
}
