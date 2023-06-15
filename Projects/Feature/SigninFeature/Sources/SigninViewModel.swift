import Foundation
import BaseFeature
import Alamofire
import JwtStore
import Swinject
import AuthDomain

public class SigninViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestToSignin(
        request: SigninRequest,
        completion: @escaping (Result<Void, Error>) -> Void = { _ in }
    ) {
        AF.request(SigninTarget.signin(request))
            .responseDecodable { [weak self] (response: AFDataResponse<ManageTokenModel>) in
                switch response.result {
                case .success(let response):
                    self?.container.setToken(data: response)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                    print("Error - Signin = \(error.localizedDescription)")
                }
            }
    }
    
    func pushPhoneNumberAuth(type: FindAccountType) {
        coordinator.navigate(to: .phoneNumberAuthIsRequired(type: type))
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.[0-9])(?=.[a-zA-Z])(?=.[!@#$%^&?~])[0-9a-zA-Z!@#$%^&*?~]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return !passwordTest.evaluate(with: password)
    }
}

