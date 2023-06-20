import Foundation
import BaseFeature
import Alamofire

class EditProfileViewModel: BaseViewModel {
    func requestProfileInfo(completion: @escaping (Result<ProfileModel, Error>) -> Void = { _ in}) {
        AF.request(EditProfileTarget.searchProfileInfo)
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
}

