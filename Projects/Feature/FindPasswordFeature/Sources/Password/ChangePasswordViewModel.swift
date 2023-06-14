import Foundation
import BaseFeature
import Alamofire

class ChangePasswordViewModel: BaseViewModel {
    
    var phoneNumber: String
    
    init(coordinator: Coordinator, phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init(coordinator: coordinator)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func requestToChangePassword(newPassword: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
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
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print("Error - ChangePassword = \(error.localizedDescription)")
            }
        }
    }
    
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
}
