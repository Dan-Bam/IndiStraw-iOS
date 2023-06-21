import Foundation
import BaseFeature
import Alamofire
import JwtStore
import Swinject

class EditProfileViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestProfileInfo(completion: @escaping (Result<ProfileModel, Error>) -> Void = { _ in}) {
        AF.request(
            EditProfileTarget.searchProfileInfo,
            interceptor: JwtRequestInterceptor(jwtStore: container))
            .validate()
            .responseDecodable(of: ProfileModel.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print("Error - ProfileInfo = \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
}

