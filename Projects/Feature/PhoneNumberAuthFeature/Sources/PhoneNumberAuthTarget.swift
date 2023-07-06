import UIKit
import Alamofire
import RouterDomain

enum PhoneNumberAuthTarget {
    case checkPhoneNumberDuplication(phoneNumber: String, type: String)
    case sendAuthNumber(phoneNumber: String)
    case checkAuthNumber(authCode: String, phoneNumber: String)
    case changePhoneNumber(phoneNumber: String)
}

extension PhoneNumberAuthTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: RouterDomain.HeaderType {
        switch self {
        case .changePhoneNumber:
            return .withToken
        default:
            return .notHeader
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .checkPhoneNumberDuplication: return .head
        case .sendAuthNumber: return .post
        case .checkAuthNumber: return .get
        case .changePhoneNumber: return .patch
        }
    }
    
    var path: String {
        switch self {
        case .checkPhoneNumberDuplication(let phoneNumber, let type):
            return "/auth/check/phone-number/\(phoneNumber)/type/\(type)"
        case .sendAuthNumber(let phoneNumber):
            return "/auth/send/phone-number/\(phoneNumber)"
        case .checkAuthNumber(let authCode, let phoneNumber):
            return "/auth/auth-code/\(authCode)/phone-number/\(phoneNumber)"
        case .changePhoneNumber(let phoneNumber):
            return "/account/phone-number/\(phoneNumber)"
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
