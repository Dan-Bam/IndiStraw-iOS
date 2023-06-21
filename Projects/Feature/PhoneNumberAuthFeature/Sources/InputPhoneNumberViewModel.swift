import Foundation
import BaseFeature
import Alamofire
import AuthDomain
import JwtStore

public class InputPhoneNumberViewModel: BaseViewModel {
    var container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestToSendAuthNumber(
        phoneNumber: String,
        completion: @escaping (Result<Void, PhoneNumberErrorType>) -> Void = { _ in }) {
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
    
    func requestToCheckDuplicationPhoneNumber(
        phoneNumber: String,
        completion: @escaping (Result<Void, CheckPhoneDuplicateErrorType>) -> Void = { _ in }) {
        AF.request(PhoneNumberAuthTarget.checkPhoneNumberDuplication(phoneNumber: phoneNumber, type: CheckPhoneDuplicateType.findAccount))
            .validate()
            .responseData { response in
                switch response.response?.statusCode {
                case 204:
                    completion(.success(()))
                case 404:
                    completion(.failure(.cantFindPhoneNumber))
                    print("Error - inputPhoneNumber = \(response.response?.statusCode)")
                default:
                    completion(.failure(.faildRequest))
                    print("Error - inputPhoneNumber = \(response.response?.statusCode)")
                }
            }
    }
    
    func requestToCheckAuthNumber(
        authCode: String,
        phoneNumber: String,
        completion: @escaping (Result<Void, PhoneNumberErrorType>) -> Void = { _ in }) {
        AF.request(PhoneNumberAuthTarget.checkAuthNumber(authCode: authCode, phoneNumber: phoneNumber))
            .validate()
            .responseData { response in
                print("statusc = \(response.response?.statusCode)")
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
    
    func reqeustToChangePhoneNumber(phoneNumber: String, completion: @escaping (Result<Void, PhoneNumberErrorType>) -> Void = { _ in }) {
        AF.request(
            PhoneNumberAuthTarget.changePhoneNumber(
                phoneNumber: phoneNumber),
                interceptor: JwtRequestInterceptor(jwtStore: container)
        )
        .validate()
        .responseData { [weak self] response in
            print("ChangePhoneNUmber = \(response.response?.statusCode)")
            switch response.response?.statusCode {
            case 205:
                self?.popToRootVC()
            default:
                return
            }
        }
    }
    
    func pushFindId(phoneNumber: String) {
        coordinator.navigate(to: .findIdIsRequired(phoneNumber: phoneNumber))
    }
    
    func pushChangePassword(phoneNumber: String) {
        coordinator.navigate(to: .changePasswordIsRequired(phoneNumber: phoneNumber))
    }
    
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
}
