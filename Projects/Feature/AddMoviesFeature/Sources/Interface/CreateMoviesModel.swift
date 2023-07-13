struct CreateMoviesModel: Encodable {
    var title: String
    var description: String
    var movie_url: String
    var thumbnail_url: String
    var movie_highlight: [String]
    var director: [Int]
    var actor: [Int]
    var clowd_true: Bool
}
