import UIKit
import Alamofire
import RouterDomain
import BaseFeature

enum EditProfileTarget {
    case searchProfileInfo
    case editProfile(EditProfileModel)
}

extension EditProfileTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: RouterDomain.HeaderType {
        switch self {
        case .searchProfileInfo: return .withToken
        case .editProfile: return .withToken
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .searchProfileInfo: return .get
        case .editProfile: return .patch
        }
    }
    
    var path: String {
        switch self {
        case .searchProfileInfo:
            return "/account/profile"
        case .editProfile:
            return "/account/profile"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .editProfile(let request):
            let body: [String : Any] = [
                "name": request.name,
                "profileUrl": request.profileUrl,
            ]
            return .requestBody(body)
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
