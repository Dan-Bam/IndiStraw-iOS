struct ProfileModel: Decodable {
    var id: String
    var name: String
    var phoneNumber: String
    var address: String?
    var profileUrl: String?
}

struct EditProfileModel: Encodable {
    var name: String
    var profileUrl: String?
}
