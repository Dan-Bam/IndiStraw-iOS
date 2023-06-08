import Foundation

struct SignupRequest: Encodable {
    var id: String
    var password: String
    var name: String
    var phoneNumber: String
    var profileUrl: String?
    
//    private init(id: String, password: String, name: String, phoneNumber: String, profileUrl: String? = nil) {
//        self.id = id
//        self.password = password
//        self.name = name
//        self.phoneNumber = phoneNumber
//        self.profileUrl = profileUrl
//    }
}
