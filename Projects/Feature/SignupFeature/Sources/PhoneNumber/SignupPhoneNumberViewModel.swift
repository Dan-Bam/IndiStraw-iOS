import Foundation
import BaseFeature
import Alamofire

public class SignupPhoneNumberViewModel: BaseViewModel {
    var name: String
    
    public init(coordinator: Coordinator, name: String) {
        self.name = name
        super.init(coordinator: coordinator)
    }
    
    func requestToSendAuthNumber(
        phoneNumber: String,
        completion: @escaping (Result<Void, PhoneNumberErrorType>) -> Void = { _ in }) {
        AF.request(SignupTarget.sendAuthNumber(phoneNumber: phoneNumber))
            .validate()
            .responseData { response in
                switch response.response?.statusCode {
                case 204:
                    completion(.success(()))
                case 429:
                    completion(.failure(.tooManyRequestException))
                case 400:
                    completion(.failure(.cantSendAuthNumber))
                default:
                    completion(.failure(.cantSendAuthNumber))
                }
            }
    }
    
    func requestToCheckDuplicationPhoneNumber(
        phoneNumber: String,
        completion: @escaping (Result<Void, CheckPhoneDuplicateErrorType>) -> Void = { _ in }) {
        AF.request(SignupTarget.checkPhoneNumberDuplication(phoneNumber: phoneNumber, type: CheckPhoneDuplicateType.signup))
            .validate()
            .responseData { response in
                switch response.response?.statusCode {
                case 204:
                    completion(.success(()))
                case 409:
                    completion(.failure(.duplicatePhoneNumber))
                default:
                    completion(.failure(.faildRequest))
                }
            }
    }
    
    func requestToCheckAuthNumber(
        authCode: String,
        phoneNumber: String,
        completion: @escaping (Result<Void, PhoneNumberErrorType>) -> Void = { _ in }) {
        AF.request(SignupTarget.checkAuthNumber(authCode: authCode, phoneNumber: phoneNumber))
            .validate()
            .responseData { response in
                switch response.response?.statusCode {
                case 204:
                    completion(.success(()))
                case 429:
                    completion(.failure(.tooManyRequestException))
                case 400:
                    completion(.failure(.cantSendAuthNumber))
                default:
                    completion(.failure(.cantSendAuthNumber))
                }
            }
    }
    
    func pushProfileImageVC(phoneNumber: String) {
        coordinator.navigate(to: .selectPhotoIsRequired(name: name, phoneNumber: phoneNumber))
    }
}
