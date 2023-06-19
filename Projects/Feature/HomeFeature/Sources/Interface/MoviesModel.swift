import Foundation

struct MovieesModel: Decodable {
    var movieIdx = UUID().uuidString
    var imageUrl: String
    
}
