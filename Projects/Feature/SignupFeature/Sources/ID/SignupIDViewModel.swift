import Foundation
import BaseFeature
import AuthDomain
import Alamofire

class SignupIDViewModel: BaseViewModel {
    func pushPasswordVC() {
        coordinator.navigate(to: .inputPasswordIsRequired)
    }
    
    func requestToCheckDuplicationID(id: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
        AF.request(SignupTarget.checkIdDuplication(id: id))
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
