import UIKit
import Alamofire
import AuthDomain

enum FindIdTarget {
    case findId(FindIdModelEncodable)
}

extension FindIdTarget: BaseRouter {
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
        case .findId:
            return "/account/phone-number/{phoneNumber}"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .findId(let request):
            let body: [String: Any] = [
                "phoneNumber": request.phoneNumber
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
