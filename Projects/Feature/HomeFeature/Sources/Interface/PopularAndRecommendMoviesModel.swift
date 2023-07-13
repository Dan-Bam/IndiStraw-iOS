struct PopularAndRecommendMoviesModel: Decodable {
    var movieIdx: Int
    var thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case movieIdx = "movie_idx"
        case thumbnailUrl = "thumbnail_url"
    }
}
