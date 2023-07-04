import UIKit
import Alamofire
import AuthDomain

enum CrowdFundingTarget {
    case requestCrowdFundingDetail(idx: Int)
}

extension CrowdFundingTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: AuthDomain.HeaderType {
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
        case .requestCrowdFundingDetail(let idx):
            return "/crowdfunding/\(idx)"
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