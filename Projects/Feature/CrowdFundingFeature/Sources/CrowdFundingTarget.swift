//import UIKit
//import Alamofire
//import AuthDomain
//
//enum CrowdFundingTarget {
//    case requestCrowdFundingList(CrowdFundingRequest)
//}
//
//extension CrowdFundingTarget: BaseRouter {
//    var baseURL: String {
//        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
//    }
//    
//    var header: AuthDomain.HeaderType {
//        switch self {
//        default: return .withToken
//        }
//    }
//    
//    var method: Alamofire.HTTPMethod {
//        switch self {
//        default: return .get
//        }
//    }
//    
//    var path: String {
//        switch self {
//        default: return "/list"
//        }
//    }
//    
//    var parameters: RequestParams {
//        switch self {
//        case .requestCrowdFundingList(let request):
//            let query: [String : Any] = [
//                "page": request.page,
//                "size": request.size,
//            ]
//            return .query(query)
//        }
//    }
//    
//    var multipart: Alamofire.MultipartFormData {
//        switch self {
//        default: return MultipartFormData()
//        }
//    }
//    
//}
