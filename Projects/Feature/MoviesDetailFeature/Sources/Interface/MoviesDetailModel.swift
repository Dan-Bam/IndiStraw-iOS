import Foundation
struct MoviesDetailModel: Decodable {
    var title: String
    var description: String
    var director: [Director]
    var actor: [Actor]
    var genre: [String]
    var imageUrl: [String]
    var thumbnail: String
    var movieUrl: String
}

struct Director: Decodable {
    var idx = UUID().uuidString
    var name: String
}

struct Actor: Decodable {
    var idx = UUID().uuidString
    var name: String
}
