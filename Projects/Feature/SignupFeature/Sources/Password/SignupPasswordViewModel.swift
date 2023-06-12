import UIKit
import BaseFeature
import Alamofire

class SignupPasswordViewModel: BaseViewModel {
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    
    func requestToUploadImage(image: UIImage?) {
        AF.upload(
            multipartFormData: SignupTarget.uploadImage(image: image).multipart,
            with: SignupTarget.uploadImage(image: image)).responseDecodable(of: ProfileImageModel.self) { [weak self] response in
//                switch response.result {
//                case .success(let data):
//                    self?.pushInputIDVC()
//                case .failure(let error):
//                    print("Error - ImageUpload = \(error.localizedDescription)")
//                }
            }
    }
}
