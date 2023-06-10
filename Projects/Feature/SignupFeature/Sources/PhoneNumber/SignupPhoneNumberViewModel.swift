import Foundation
import BaseFeature
import AuthDomain
import JwtStore
import Alamofire

enum SignupPhoneNumberErrorType: Error {
    case cantSendAuthNumber
    case tooManyRequestException
}

class SignupPhoneNumberViewModel: BaseViewModel {
    var container = DIContainer.shared.resolve(JwtStore.self)!
    
    var name: String
    
    init(coordinator: Coordinator, name: String) {
        self.name = name
        super.init(coordinator: coordinator)
    }
    
    func requestToSendAuthNumber(phoneNumber: String, completion: @escaping (Result<Void, SignupPhoneNumberErrorType>) -> Void = { _ in }) {
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
    
    func requestToCheckDuplicationPhoneNumber(phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
        AF.request(SignupTarget.checkPhoneNumberDuplication(phoneNumber: phoneNumber))
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                    print("Error - inputPhoneNumber = \(error.localizedDescription)")
                }
            }
    }
    
    func requestToCheckAuthNumber(authCode: String, phoneNumber: String, completion: @escaping (Result<Void, SignupPhoneNumberErrorType>) -> Void = { _ in }) {
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
    
    func pushProfileImageVC() {
        coordinator.navigate(to: .selectPhotoIsRequired)
    }
}
