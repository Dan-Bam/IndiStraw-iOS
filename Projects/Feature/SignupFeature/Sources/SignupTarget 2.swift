import Alamofire
import AuthDomain

enum SignupTarget {
    case signup(SignupRequest)
    case checkPhoneNumberDuplication(phoneNumber: String)
    case checkIdDuplication(id: String)
    case sendAuthNumber(phoneNumber: String)
    case checkAuthNumber(authCode: String, phoneNumber: String)
    
}

extension SignupTarget: TargetType {
    var baseURL: String {
        return "https://port-0-indistraw-account-otjl2cli73l2cy.sel4.cloudtype.app/api/v1/auth"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signup: return .post
        case .checkPhoneNumberDuplication: return .head
        case .checkIdDuplication: return .head
        case .sendAuthNumber: return .post
        case .checkAuthNumber: return .get
        }
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/signup"
        case .checkPhoneNumberDuplication(let phoneNumber):
            return "/check/phone-number/\(phoneNumber)"
        case .checkIdDuplication(id: let id):
            return "/check/id/\(id)"
        case .sendAuthNumber(phoneNumber: let phoneNumber):
            return "/send/phone-number/\(phoneNumber)"
        case .checkAuthNumber(authCode: let authCode, phoneNumber: let phoneNumber):
            return "/auth-code/\(authCode)/phone-number/\(phoneNumber)"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signup(let request):
            return .body(request)
        case .checkPhoneNumberDuplication,
             .checkIdDuplication,
             .sendAuthNumber,
             .checkAuthNumber:
            return .query(nil)
        }
    }
    
}
