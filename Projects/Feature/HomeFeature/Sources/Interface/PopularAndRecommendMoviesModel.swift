struct PopularAndRecommendMoviesModel: Codable {
    var isLast: Bool
    var movieIdx: Int
    var thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case isLast
        case movieIdx = "movie_idx"
        case thumbnailUrl = "thumbnail_url"
    }
}
