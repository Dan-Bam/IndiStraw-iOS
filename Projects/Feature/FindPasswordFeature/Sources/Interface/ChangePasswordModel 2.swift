import Foundation

struct ChangePasswordModel: Encodable {
    var phoneNumber: String
    var newPassword: String
}
