import UIKit
import BaseFeature
import Alamofire

class SignupIDViewModel: BaseViewModel {
    var image: UIImage?
    var name: String
    var phoneNumber: String
    
    init(coordinator: Coordinator, image: UIImage?, name: String, phoneNumber: String) {
        self.image = image
        self.name = name
        self.phoneNumber = phoneNumber
        super.init(coordinator: coordinator)
    }
    
    func pushPasswordVC(id: String) {
        coordinator.navigate(to: .inputPasswordIsRequired(id: id, name: name, phoneNumber: phoneNumber, profileImage: image))
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
