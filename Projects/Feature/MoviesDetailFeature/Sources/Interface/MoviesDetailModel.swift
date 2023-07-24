import Foundation
struct MoviesDetailModel: Decodable {
    var title: String
    var description: String
    var movieUrl: String
    var thumbnailUrl: String
    var director: [Director]
    var actor: [Actor]
    var movieHighlight: [String]
    var isClowd: Bool
    var genre: [String]
    
    enum CodingKeys: String, CodingKey {
        case title, description, genre, director, actor
        case movieUrl = "movie_url"
        case thumbnailUrl = "thumbnail_url"
        case movieHighlight = "movie_highlight"
        case isClowd = "clowd_true"
    }
}

struct Director: Decodable {
    var directorIdx: DirectorIdx
}

struct DirectorIdx: Decodable {
    var profileUrl: String
    var name: String
}

struct Actor: Decodable {
    var actorIdx: ActorIdx
    var idx = UUID().uuidString
    var name: String
}

struct ActorIdx: Decodable {
    var profileUrl: String
    var name: String
}
