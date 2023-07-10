import UIKit
import Alamofire
import RouterDomain

enum CrowdFundingTarget {
    case requestCrowdFundingList(CrowdFundingListRequest)
    case requestCrowdFundingDetail(idx: Int)
}

extension CrowdFundingTarget: BaseRouter {
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
        case .requestCrowdFundingDetail(let idx):
            return "/crowdfunding/\(idx)"
        case .requestCrowdFundingList:
            return "/crowdfunding/list"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .requestCrowdFundingList(let data):
            let query: [String: Any] = [
                "page": data.page,
                "size": data.size
            ]
            return .query(query )
        default: return .requestPlain
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        default: return MultipartFormData()
        }
    }
    
}
