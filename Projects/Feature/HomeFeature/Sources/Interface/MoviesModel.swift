import Foundation

struct MoviesModel: Codable {
    var movieIdx = UUID().uuidString
    var imageUrl: String
}
