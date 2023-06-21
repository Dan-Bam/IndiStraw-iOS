import UIKit
import Alamofire
import AuthDomain
import BaseFeature

enum AddressTarget {
    case searchAddress(AddressModel)
}

extension AddressTarget: BaseRouter {
    var baseURL: String {
        return ""
    }
    
    var header: AuthDomain.HeaderType {
        switch self {
        case .searchAddress: return .withToken
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .searchAddress: return .post
        }
    }
    
    var path: String {
        return ""
    }
    
    var parameters: RequestParams {
        switch self {
        case .searchAddress(let request):
            let body: [String : Any] = [
                "confmKey": request.confmKey,
                "currentPage": request.currentPage,
                "countPerPage": request.countPerPage,
                "keyword": request.keyword,
                "resultType": request.resultType
                
            ]
            return .requestBody(body)
        default:
            return .requestPlain
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        default: return MultipartFormData()
        }
    }
    
}
