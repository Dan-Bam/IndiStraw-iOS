struct MovieListRequestModel: Encodable {
    var page: Int
    var keyward: String?
}

struct MovieListResponseModel: Codable {
    var isLast: Bool
    var list: [MovieList]
}

struct MovieList: Codable {
    var movieIdx: Int
    var thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case movieIdx = "movie_idx"
        case thumbnailUrl = "thumbnail_url"
    }
}

struct WatchHistorydMoviesModel: Decodable {
    var title: String
    var thumbnailUrl: String
    var historyTime: Float
    var movieIdx: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailUrl = "thumbnail_url"
        case historyTime = "history_time"
        case movieIdx = "movie_idx"
    }
}
