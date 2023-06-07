import Foundation
import BaseFeature
import Alamofire
import JwtStore
import Swinject

public class SigninViewModel: BaseViewModel {
    let container = Container().resolve(JwtStore.self)!
    
    func requestToSignin(request: SigninRequest, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
        AF.request(SigninTarget.signin(request))
            .responseDecodable { [weak self] (response: AFDataResponse<ManageTokenModel>) in
                switch response.result {
                case .success(let response):
                    self?.container.setToken(data: response)
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
