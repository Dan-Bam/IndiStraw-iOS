import UIKit
import BaseFeature
import Alamofire

class SignupProfileImageViewModel: BaseViewModel {
    
    var name: String
    var phoneNumber: String
    
    init(coordinator: Coordinator, name: String, phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        super.init(coordinator: coordinator)
    }
    
    func requestToUploadImage(image: UIImage) {
        AF.upload(
            multipartFormData: SignupTarget.uploadImage(image: image).multipart,
            with: SignupTarget.uploadImage(image: image)).responseDecodable(of: ProfileImageModel.self) { [weak self] response in
                switch response.result {
                case .success(let data):
                    self?.pushInputIDVC()
                case .failure(let error):
                    print("Error - ImageUpload = \(error.localizedDescription)")
                }
            }
    }
    
    func pushInputIDVC() {
        coordinator.navigate(to: .inputIDIsRequired)
    }
}
    
