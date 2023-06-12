import UIKit
import Alamofire
import AuthDomain

enum SignupTarget {
    case signup(SignupRequest)
    case checkPhoneNumberDuplication(phoneNumber: String)
    case checkIdDuplication(id: String)
    case sendAuthNumber(phoneNumber: String)
    case checkAuthNumber(authCode: String, phoneNumber: String)
    case uploadImage(image: UIImage)
}

extension SignupTarget: TargetType {
    var baseURL: String {
        return "https://port-0-indistraw-account-otjl2cli73l2cy.sel4.cloudtype.app/api/v1"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signup: return .post
        case .checkPhoneNumberDuplication: return .head
        case .checkIdDuplication: return .head
        case .sendAuthNumber: return .post
        case .checkAuthNumber: return .get
        case .uploadImage: return .post
        }
    }
    
    var path: String {
        switch self {
        case .signup:
            return "/auth/signup"
        case .checkPhoneNumberDuplication(let phoneNumber):
            return "/auth/check/phone-number/\(phoneNumber)"
        case .checkIdDuplication(id: let id):
            return "/auth/check/id/\(id)"
        case .sendAuthNumber(phoneNumber: let phoneNumber):
            return "/auth/send/phone-number/\(phoneNumber)"
        case .checkAuthNumber(authCode: let authCode, phoneNumber: let phoneNumber):
            return "/auth/auth-code/\(authCode)/phone-number/\(phoneNumber)"
        case .uploadImage(image: let image):
            return "/file"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signup(let request):
            return .body(request)
        default:
            return .query(nil)
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        case .uploadImage(let image):
            let multiPart = MultipartFormData()
            
            let imageData = image.pngData() ?? Data()
            multiPart.append(imageData, withName: "file", fileName: "Image.png", mimeType: "image/png")
            
            return multiPart
        default: return MultipartFormData()
        }
    }
    
}
