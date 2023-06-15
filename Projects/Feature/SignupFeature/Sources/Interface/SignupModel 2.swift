import Foundation

struct SignupRequest: Encodable {
    var id: String
    var password: String
    var name: String
    var phoneNumber: String
    var profileUrl: String?
}
