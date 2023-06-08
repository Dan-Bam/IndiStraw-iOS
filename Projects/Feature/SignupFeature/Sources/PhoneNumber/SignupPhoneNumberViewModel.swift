import Foundation
import BaseFeature
import AuthDomain
import JwtStore
import Alamofire

class SignupPhoneNumberViewModel: BaseViewModel {
    var container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestDuplicatePhoneNumber(phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
        AF.request(SignupTarget.checkPhoneNumberDuplication(phoneNumber: phoneNumber))
            .responseData { response in
                switch response.result {
                case .success:
                    print("success")
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                    print("Error - inputPhoneNumber = \(error.localizedDescription)")
                }
            }
    }
    
    func pushProfileImageVC() {
        coordinator.navigate(to: .selectPhotoIsRequired)
    }
}
