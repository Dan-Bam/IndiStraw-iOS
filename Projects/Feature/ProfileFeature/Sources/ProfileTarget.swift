import UIKit
import Alamofire
import RouterDomain

enum ProfileTarget {
    case requestProfileName
    case requestMyFunding
}

extension ProfileTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: RouterDomain.HeaderType {
        switch self {
            default: return .withToken
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
            default: return .get
        }
    }
    
    var path: String {
        switch self {
        case .requestMyFunding: return "/crowdfunding/my"
            default: return "/account/info"
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
