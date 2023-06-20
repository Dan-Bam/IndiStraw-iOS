import UIKit
import Alamofire
import AuthDomain
import BaseFeature

enum EditProfileTarget {
}

extension SignupTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: AuthDomain.HeaderType {
        switch self {
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        }
    }
    
    var path: String {
        switch self {
        }
    }
    
    var parameters: RequestParams {
        switch self {
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        default: return MultipartFormData()
        }
    }
    
}
