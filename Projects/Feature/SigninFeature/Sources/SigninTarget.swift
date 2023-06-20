import Alamofire
import Foundation
import AuthDomain

enum SigninTarget {
    case signin(SigninRequest)
}

extension SigninTarget: BaseRouter {
    var baseURL: String {
        "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: AuthDomain.HeaderType {
        return .notHeader
    }
    
    var multipart: Alamofire.MultipartFormData {
        return MultipartFormData()
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signin: return .post
        }
    }
    
    var path: String {
        switch self {
        case .signin: return "/auth/signin"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signin(let request):
            let body: [String : Any] = [
                "id": request.id,
                "password": request.password,
            ]
            return .requestBody(body)
        }
    }
}
