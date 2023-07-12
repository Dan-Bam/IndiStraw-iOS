import Foundation

struct PopularMoviesModel: Codable {
    var movieIdx: Int
    var thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case movieIdx = "movie_idx"
        case thumbnailUrl = "thumbnail_url"
    }
}
