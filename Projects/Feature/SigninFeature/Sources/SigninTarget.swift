import Alamofire
import Foundation
import AuthDomain

enum SigninTarget {
    case signin(SigninRequest)
}

extension SigninTarget: BaseRouter {
    
    var multipart: Alamofire.MultipartFormData {
        return MultipartFormData()
    }
    
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
        case .signin(let request):
            let body: [String : Any] = [
                "id": request.id,
                "password": request.password,
            ]
            return .requestBody(body)
        }
    }
    
    
}
