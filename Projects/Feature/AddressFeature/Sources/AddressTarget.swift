import UIKit
import Alamofire
import AuthDomain
import BaseFeature

enum AddressTarget {
    case searchAddress(RequestAddressModel)
    case changeAddress(ChangeAddressModel)
}

extension AddressTarget: BaseRouter {
    var baseURL: String {
        switch self {
        case .searchAddress:
            return "https://business.juso.go.kr/addrlink"
        case .changeAddress:
            return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
        }
    }
    
    var header: AuthDomain.HeaderType {
        switch self {
        case .searchAddress: return .notHeader
        case .changeAddress: return .withToken
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .searchAddress: return .get
        case .changeAddress: return .patch
        }
    }
    
    var path: String {
        switch self {
        case .searchAddress:
            return "/addrLinkApi.do"
        case .changeAddress:
            return "/account/address"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .searchAddress(let request):
            let query: [String : Any] = [
                "confmKey": request.confmKey,
                "currentPage": request.currentPage,
                "countPerPage": request.countPerPage,
                "keyword": request.keyword,
                "resultType": request.resultType
            ]
            return .query(query)
        
        case .changeAddress(let request):
            let body: [String: Any] = [
                "zipcode": request.zipcode,
                "streetAddress": request.streetAddress,
                "detailAddress": request.detailAddress
            ]
            return .requestBody(body)
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        default: return MultipartFormData()
        }
    }
    
}
