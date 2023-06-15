import UIKit
import Alamofire
import AuthDomain

enum FindIdTarget {
    case findId(FindIdModelEncodable)
}

extension FindIdTarget: BaseRouter {
    var header: AuthDomain.HeaderType {
        switch self {
        case .findId: return .notHeader
        }
    }
    
    var baseURL: String {
        return "https://port-0-indistraw-account-otjl2cli73l2cy.sel4.cloudtype.app/api/v1"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .findId: return .get
        }
    }
    
    var path: String {
        switch self {
        case .findId(let data):
            return "/account/phone-number/\(data.phoneNumber)"
        }
    }
    
    var parameters: RequestParams {
        switch self {
            default: return .requestPlain
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
            default: return MultipartFormData()
        }
    }
    
}
