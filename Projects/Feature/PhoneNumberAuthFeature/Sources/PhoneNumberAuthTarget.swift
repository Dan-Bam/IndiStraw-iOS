import UIKit
import Alamofire
import AuthDomain

enum PhoneNumberAuthTarget {
    case checkPhoneNumberDuplication(phoneNumber: String, type: String)
    case sendAuthNumber(phoneNumber: String)
    case checkAuthNumber(authCode: String, phoneNumber: String)
}

extension PhoneNumberAuthTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-account-otjl2cli73l2cy.sel4.cloudtype.app/api/v1"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .checkPhoneNumberDuplication: return .head
        case .sendAuthNumber: return .post
        case .checkAuthNumber: return .get
        }
    }
    
    var path: String {
        switch self {
        case .checkPhoneNumberDuplication(let phoneNumber, let type):
            return "/auth/check/phone-number/\(phoneNumber)/type/\(type)"
        case .sendAuthNumber(phoneNumber: let phoneNumber):
            return "/auth/send/phone-number/\(phoneNumber)"
        case .checkAuthNumber(authCode: let authCode, phoneNumber: let phoneNumber):
            return "/auth/auth-code/\(authCode)/phone-number/\(phoneNumber)"
        }
    }
    
    var parameters: RequestParams {
        switch self {
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
