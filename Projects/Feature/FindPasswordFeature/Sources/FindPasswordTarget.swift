import UIKit
import Alamofire
import AuthDomain

enum FindPasswordTarget {
    case checkPhoneNumberDuplication(phoneNumber: String)
    case sendAuthNumber(phoneNumber: String)
    case checkAuthNumber(authCode: String, phoneNumber: String)
    case changePasswrod(ChangePasswordModel)
}

extension FindPasswordTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-account-otjl2cli73l2cy.sel4.cloudtype.app/api/v1"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .checkPhoneNumberDuplication: return .head
        case .sendAuthNumber: return .post
        case .checkAuthNumber: return .get
        case .changePasswrod: return .patch
        }
    }
    
    var path: String {
        switch self {
        case .checkPhoneNumberDuplication(let phoneNumber):
            return "/auth/check/phone-number/\(phoneNumber)"
        case .sendAuthNumber(phoneNumber: let phoneNumber):
            return "/auth/send/phone-number/\(phoneNumber)"
        case .checkAuthNumber(authCode: let authCode, phoneNumber: let phoneNumber):
            return "/auth/auth-code/\(authCode)/phone-number/\(phoneNumber)"
        case .changePasswrod:
            return "/account/update/password"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .changePasswrod(let request):
            let body: [String : Any] = [
                "phoneNumber": request.phoneNumber,
                "newPassword": request.newPassword,
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
