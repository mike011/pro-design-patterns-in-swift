struct Donor {
    let title: String
    let firstName: String
    let familyName: String
    let lastDonation: Float

    init(title: String, first: String, family: String, last: Float) {
        self.title = title
        firstName = first
        familyName = family
        lastDonation = last
    }
}

class DonorDatabase {
    private var donors: [Donor]

    init() {
        donors = [
            Donor(title: "Ms", first: "Anne", family: "Jones", last: 0),
            Donor(title: "Mr", first: "Bob", family: "Smith", last: 100),
            Donor(title: "Dr", first: "Alice", family: "Doe", last: 200),
            Donor(title: "Prof", first: "Joe", family: "Davis", last: 320),
        ]
    }

    func filter(donors: [Donor]) -> [Donor] {
        return donors.filter { $0.lastDonation > 0 }
    }

    func generate(donors: [Donor]) -> [String] {
        return donors.map { donor in
            "Dear \(donor.title). \(donor.familyName)"
        }
    }

    func generate(maxNumber: Int) -> [String] {
        // step 1 - filter out non-donors
        var targetDonors = filter(donors: donors)

        // step 2 - order donors by last donation
        targetDonors.sort { $0.lastDonation > $1.lastDonation }

        // step 3 - limit the number of invitees
        if targetDonors.count > maxNumber {
            targetDonors = Array(targetDonors[0 ..< maxNumber])
        }

        // step 4 - generate the invitations
        return generate(donors: targetDonors)
    }
}
