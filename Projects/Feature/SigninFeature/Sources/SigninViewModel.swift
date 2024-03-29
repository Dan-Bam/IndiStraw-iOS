import Foundation
import BaseFeature
import Alamofire
import JwtStore
import Swinject

public class SigninViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestToSignin(
        request: SigninRequest,
        completion: @escaping (Result<Void, Error>) -> Void = { _ in }
    ) {
        AF.request(SigninTarget.signin(request))
            .validate()
            .responseDecodable(of: ManageTokenModel.self) { [weak self] response in
                switch response.result {
                case .success(let response):
                    print("token  =  \(response)")
                    self?.container.setToken(data: response)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                    print("Error - Signin = \(error.localizedDescription)")
                }
            }
    }
    
    func pushPhoneNumberAuth(type: InputPhoneNumberType) {
        coordinator.navigate(to: .phoneNumberAuthIsRequired(type: type))
    }
    
    func setHomeView() {
        coordinator.navigate(to: .setHomeIsRequired)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.[0-9])(?=.[a-zA-Z])(?=.[!@#$%^&?~])[0-9a-zA-Z!@#$%^&*?~]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return !passwordTest.evaluate(with: password)
    }
}

