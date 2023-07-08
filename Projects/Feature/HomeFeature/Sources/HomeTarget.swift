import UIKit
import Alamofire
import RouterDomain

enum HomeTarget {
    case requestPopularMoviesList
    case requestCrowdFundingList
}

extension HomeTarget: BaseRouter {
    var baseURL: String {
        switch self {
        case .requestPopularMoviesList:
            return "http://3.38.100.249:8001/api/v1"
        default: return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
        }
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
        case .requestPopularMoviesList: return "/movie/"
        case .requestCrowdFundingList: return "/crowdfunding/popular/list"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .requestCrowdFundingList, .requestPopularMoviesList:
            return .requestPlain
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        default: return MultipartFormData()
        }
    }
    
}
