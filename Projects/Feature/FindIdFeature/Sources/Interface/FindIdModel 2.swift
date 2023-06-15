import Foundation

struct FindIdModelEncodable: Encodable {
    var phoneNumber: String
}

struct FindIdModelDecodable: Decodable {
    var id: String
}
