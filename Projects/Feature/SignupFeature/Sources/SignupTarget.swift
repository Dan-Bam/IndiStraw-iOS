import UIKit
import Alamofire
import RouterDomain
import BaseFeature

enum SignupTarget {
    case signup(SignupRequest)
    case checkPhoneNumberDuplication(phoneNumber: String, type: String)
    case checkIdDuplication(id: String)
    case sendAuthNumber(phoneNumber: String)
    case checkAuthNumber(authCode: String, phoneNumber: String)
    case uploadImage(image: UIImage)
}

extension SignupTarget: BaseRouter {
    var baseURL: String {
        return "https://port-0-indistraw-msa-server-dihik2mlj29oc6u.sel4.cloudtype.app/api/v1"
    }
    
    var header: RouterDomain.HeaderType {
        switch self {
        case .uploadImage: return .multiPart
        default: return .notHeader
        }
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
        case .checkPhoneNumberDuplication(let phoneNumber, let type):
            return "/auth/check/phone-number/\(phoneNumber)/type/\(type)"
        case .checkIdDuplication(id: let id):
            return "/auth/check/id/\(id)"
        case .sendAuthNumber(phoneNumber: let phoneNumber):
            return "/auth/send/phone-number/\(phoneNumber)"
        case .checkAuthNumber(authCode: let authCode, phoneNumber: let phoneNumber):
            return "/auth/auth-code/\(authCode)/phone-number/\(phoneNumber)"
        case .uploadImage:
            return "/file/"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .signup(let request):
            let body: [String : Any] = [
                "id": request.id,
                "password": request.password,
                "name": request.name,
                "phoneNumber": request.phoneNumber,
                "profileUrl": request.profileUrl
            ]
            return .requestBody(body)
        default:
            return .requestPlain
        }
    }
    
    var multipart: Alamofire.MultipartFormData {
        switch self {
        case .uploadImage(let image):
            let multiPart = MultipartFormData()
            
            let imageData = image.pngData() ?? Data()
            multiPart.append(imageData, withName: "file", fileName: "image.png", mimeType: "image/png")

            return multiPart
        default: return MultipartFormData()
        }
    }
    
}
