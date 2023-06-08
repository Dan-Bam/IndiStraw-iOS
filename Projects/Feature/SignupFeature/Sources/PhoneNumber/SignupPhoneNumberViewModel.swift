import Foundation
import BaseFeature
import AuthDomain
import JwtStore
import Alamofire

class SignupPhoneNumberViewModel: BaseViewModel {
    var container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestDuplicatePhoneNumber(phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
        AF.request(SignupTarget.sendAuthNumber(phoneNumber: phoneNumber))
            .responseDecodable { (response: AFDataResponse<Data>) in
                switch response.result {
                case .success:
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
