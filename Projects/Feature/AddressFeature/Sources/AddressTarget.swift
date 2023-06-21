import UIKit
import Alamofire
import AuthDomain
import BaseFeature

enum AddressTarget {
    case searchAddress(RequestAddressModel)
}

extension AddressTarget: BaseRouter {
    var baseURL: String {
        return "https://business.juso.go.kr/addrlink"
    }
    
    var header: AuthDomain.HeaderType {
        switch self {
        case .searchAddress: return .notHeader
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .searchAddress: return .get
        }
    }
    
    var path: String {
        return "/addrLinkApi.do"
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
            return .query(body)
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        default: return MultipartFormData()
        }
    }
    
}
