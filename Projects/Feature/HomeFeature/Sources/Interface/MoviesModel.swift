import Foundation

struct MovieesModel: Codable {
    var movieIdx = UUID().uuidString
    var imageUrl: String
}
