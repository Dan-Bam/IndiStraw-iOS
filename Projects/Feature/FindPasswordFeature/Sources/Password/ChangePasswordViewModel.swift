import Foundation
import BaseFeature
import Alamofire

enum ChangePasswordErrorType: Error {
    case sameAsExistingPassword
    case failedRequest
}

public class ChangePasswordViewModel: BaseViewModel {
    
    var phoneNumber: String
    
    public init(coordinator: Coordinator, phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init(coordinator: coordinator)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func requestToChangePassword(
        newPassword: String,
        completion: @escaping (Result<Void, ChangePasswordErrorType>) -> Void = { _ in }) {
        AF.request(
            FindPasswordTarget.changePasswrod(
                ChangePasswordModel(
                    phoneNumber: phoneNumber,
                    newPassword: newPassword
                )
            )
        )
        .validate()
        .responseData { response in
            switch response.response?.statusCode {
            case 205:
                completion(.success(()))
            case 409:
                completion(.failure(.sameAsExistingPassword))
            default:
                completion(.failure(.failedRequest))
            }
        }
    }
    
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
}
