import Foundation
import BaseFeature
import Alamofire
import JwtStore
import AuthDomain


class EditProfileViewModel: BaseViewModel {
    var container = DIContainer.shared.resolve(JwtStore.self)!
    func requestProfileInfo(completion: @escaping (Result<ProfileModel, Error>) -> Void = { _ in }) {
        AF.request(
            EditProfileTarget.searchProfileInfo,
            interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: ProfileModel.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToeditProfile(name: String, profileUrl: String, completion: @escaping (Result<Void, Error>) -> Void = { _ in }) {
        AF.request(
            EditProfileTarget.editProfile(EditProfileModel(
                name: name,
                profileUrl: profileUrl
            )),interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseData { response in
            
        }
    }
}

