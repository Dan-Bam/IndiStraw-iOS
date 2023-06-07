import Alamofire
import AuthDomain

enum SigninTarget {
    case signin(SigninRequest)
}

extension SigninTarget: TargetType {
    var baseURL: String {
        return "https://port-0-indistraw-account-otjl2cli73l2cy.sel4.cloudtype.app/api/v1/auth"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signin: return .post
        }
    }
    
    var path: String {
        switch self {
        case .signin: return "/signin"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signin(let request): return .body(request)
        }
    }
    
    
}
