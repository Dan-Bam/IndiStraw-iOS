import Foundation
import BaseFeature
import Alamofire

class ChangePasswordViewModel: BaseViewModel {
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func requestToChangePassword(password: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
//        AF.request(FindPasswordTarget.)
    }
}
