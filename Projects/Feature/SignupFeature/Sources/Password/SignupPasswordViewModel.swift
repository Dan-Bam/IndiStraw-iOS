import UIKit
import BaseFeature
import Alamofire

class SignupPasswordViewModel: BaseViewModel {
//    var id: String
//    var name: String
//    var phoneNumber: String
//    var profileImage: UIImage?
//
//    init(coordinator: Coordinator, id: String, name: String, phoneNumber: String, profileImage: UIImage?) {
//        self.id = id
//        self.name = name
//        self.phoneNumber = phoneNumber
//        self.profileImage = profileImage
//        super.init(coordinator: coordinator)
//        print(profileImage)
//    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func requestToUploadImage(image: UIImage?, password: String, completion: @escaping (Result<ProfileImageModel, Error>) -> Void = { _ in }) {
        AF.upload(
            multipartFormData: SignupTarget.uploadImage(image: image).multipart,
            with: SignupTarget.uploadImage(image: image)
        )
        .validate()
        .responseDecodable(of: ProfileImageModel.self) { [weak self] response in
                switch response.result {
                case .success(let data):
                    print("data = \(data.file)")
                    completion(.success(data))
                case .failure(let error):
                    print("Error - ImageUpload = \(error.localizedDescription)")
                }
            }
    }
    
    func requestToSignup(id: String, password: String, name: String, phoneNumber: String, profileUrl: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
        AF.request(
            SignupTarget.signup(SignupRequest(
                id: id,
                password: password,
                name: name,
                phoneNumber: phoneNumber,
                profileUrl: profileUrl))
        ).responseData { response in
            switch response.result {
            case .success:
                print("success - signup")
                completion(.success(()))
            case .failure(let error):
                print("Error - signup - \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
}
