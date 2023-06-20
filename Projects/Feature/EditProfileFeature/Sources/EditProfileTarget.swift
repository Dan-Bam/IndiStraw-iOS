import UIKit
import Alamofire
import AuthDomain
import BaseFeature

enum EditProfileTarget {
    case searchProfileInfo
}

extension EditProfileTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: AuthDomain.HeaderType {
        switch self {
        case .searchProfileInfo: return .withToken
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .searchProfileInfo: return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchProfileInfo:
            return "/account/profile"
        }
    }
    
    var parameters: RequestParams {
        switch self {
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
