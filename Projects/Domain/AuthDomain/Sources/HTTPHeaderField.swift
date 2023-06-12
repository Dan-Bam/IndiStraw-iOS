import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case formDataType = "multipart/form-data"
}

enum ContentType: String {
    case json = "Application/json"
}
