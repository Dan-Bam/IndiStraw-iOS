import UIKit
import Alamofire
import RouterDomain

enum HomeTarget {
    case requestPopularMoviesList
    case requestToRecommendMoviesList
    case reqeustToWatchHistoryMoviesList
    case requestCrowdFundingList
}

extension HomeTarget: BaseRouter {
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
        case .requestPopularMoviesList: return "/movie/popular/"
        case .requestToRecommendMoviesList: return "/movie/recommend/"
        case .reqeustToWatchHistoryMoviesList: return "/movie/history/"
        case .requestCrowdFundingList: return "/crowdfunding/popular/list"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .requestCrowdFundingList, .requestPopularMoviesList, .requestToRecommendMoviesList, .reqeustToWatchHistoryMoviesList:
            return .requestPlain
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        default: return MultipartFormData()
        }
    }
    
}
