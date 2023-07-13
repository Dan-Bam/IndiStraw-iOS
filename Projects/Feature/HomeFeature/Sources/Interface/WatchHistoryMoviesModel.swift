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
