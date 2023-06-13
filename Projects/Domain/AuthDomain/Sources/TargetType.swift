import Foundation
import Alamofire

public protocol BaseRouter: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
    var multipart: MultipartFormData { get }
}

public extension BaseRouter {
    // URLRequestConvertible 구현
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return urlRequest
    }
        
    private func makeParameterForRequest(to request: URLRequest, with url: URL) throws -> URLRequest {
        var request = request
        
        switch parameters {
            
        case .query(let query):
            let queryParams = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            request.url = components?.url
            
        case .requestBody(let body):
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
        case .queryBody(let query, let body):
            let queryParams = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            request.url = components?.url
            
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
        case .requestPlain:
            break
        }
        return request
    }
}

public enum RequestParams {
    case queryBody(_ query: [String : Any], _ body: [String : Any])
    case query(_ query: [String : Any])
    case requestBody(_ body: [String : Any])
    case requestPlain
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}
