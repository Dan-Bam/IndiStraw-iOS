import Foundation
import Alamofire
import Utility
import ColorfulLog

public class JwtRequestInterceptor: RequestInterceptor {
    private let jwtStore: JwtStore
    
    public init(jwtStore: JwtStore) {
        self.jwtStore = jwtStore
    }
    
    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard urlRequest.url?.absoluteString.hasPrefix(APIConstants.baseURL) == true else {
            completion(.success(urlRequest))
            return
        }
        var urlRequest = urlRequest
        completion(.success(urlRequest))
    }
    
    public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        
        let accessExpiredTime = CustomDateFormatter.shared.getStringToDate(from: jwtStore.getToken(type: .accessTokenExpiredAt))
        if accessExpiredTime?.compare(Date().addingTimeInterval(32400)) == .orderedDescending {
            completion(.doNotRetryWithError(error))
            return
        }
        
        let url = APIConstants.reissueURL
        let headers: HTTPHeaders = ["refreshToken" : "Bearer " + jwtStore.getToken(type: .refreshToken)]
        
        AF.request(url,
                   method: .patch,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: ManageTokenModel.self) { [weak self] response in
            DLog(type: .debug, text: "retry status code = \(response.response?.statusCode)")
            switch response.result {
            case .success(let data):
                print("data = \(data)")
                self?.jwtStore.deleteAll()
                self?.jwtStore.setToken(data: data)
//                completion(.retry)
                
            case .failure(let error):
                DLog(type: .error, text: "retry - \(error.localizedDescription)")
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
