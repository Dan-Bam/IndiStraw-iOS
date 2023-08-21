import UIKit
import BaseFeature
import Alamofire

enum SignupErrorType: Error {
    case failedRequest
}

public class SignupPasswordViewModel: BaseViewModel {
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func requestToUploadImage(
        image: UIImage,
        password: String,
        completion: @escaping (Result<ProfileImageModel, Error>) -> Void = { _ in }) {
        AF.upload(
            multipartFormData: SignupTarget.uploadImage(image: image).multipart,
            with: SignupTarget.uploadImage(image: image)
        )
        .validate()
        .responseDecodable(of: ProfileImageModel.self) { response in
                switch response.result {
                case .success(let data):
                    print("data = \(data.imageUrl)")
                    completion(.success(data))
                case .failure(let error):
                    print("Error - ImageUpload = \(error.localizedDescription)")
                }
            }
    }
    
    func requestToSignup(
        id: String,
        password: String,
        name: String,
        phoneNumber: String,
        profileUrl: String?,
        completion: @escaping (Result<Void, SignupErrorType>) -> Void = { _ in }) {
        AF.request(
            SignupTarget.signup(SignupRequest(
                id: id,
                password: password,
                name: name,
                phoneNumber: phoneNumber,
                profileUrl: profileUrl))
        )
        .validate()
        .responseData { response in
            switch response.response?.statusCode {
            case 201:
                print("success - signup")
                completion(.success(()))
            default:
                print("statusCode = \(response.response?.statusCode)")
                completion(.failure(.failedRequest))
            }
        }
    }
    
    func popToRootVC() {
        coordinator.navigate(to: .popToRootIsRequired)
    }
}
