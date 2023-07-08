import Foundation

struct PopularMoviesModel: Codable {
    var id: Int
    var thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbnailUrl = "thumbnail_url"
    }
}
