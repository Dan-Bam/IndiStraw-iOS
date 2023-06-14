import Foundation
import BaseFeature
import Alamofire
import AuthDomain

public class InputPhoneNumberViewModel: BaseViewModel {
    
    var type: FindAccountType
    
    public init(coordinator: Coordinator, type: FindAccountType) {
        self.type = type
        super.init(coordinator: coordinator)
    }
    
    func requestToSendAuthNumber(phoneNumber: String, completion: @escaping (Result<Void, PhoneNumberErrorType>) -> Void = { _ in }) {
        AF.request(PhoneNumberAuthTarget.sendAuthNumber(phoneNumber: phoneNumber))
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
        AF.request(PhoneNumberAuthTarget.checkPhoneNumberDuplication(phoneNumber: phoneNumber))
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
    
    func requestToCheckAuthNumber(authCode: String, phoneNumber: String, completion: @escaping (Result<Void, PhoneNumberErrorType>) -> Void = { _ in }) {
        AF.request(PhoneNumberAuthTarget.checkAuthNumber(authCode: authCode, phoneNumber: phoneNumber))
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
    
    func navigateToFindIdOrChangePassword(phoneNumber: String) {
        switch type {
        case .findId:
            coordinator.navigate(to: .findIdIsRequired(phoneNumber: phoneNumber))
        case .changePassword:
            coordinator.navigate(to: .changePasswordIsRequired(phoneNumber: phoneNumber))
        }
    }
}
