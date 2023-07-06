import Foundation
import BaseFeature
import Alamofire
import JwtStore
import Swinject


class EditProfileViewModel: BaseViewModel {
    var container = DIContainer.shared.resolve(JwtStore.self)!
    
    var profileUrl: String?
    
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
    
    func requestToeditProfile(name: String) {
        AF.request(
            EditProfileTarget.editProfile(EditProfileModel(
                name: name,
                profileUrl: profileUrl
            )),interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseData { [weak self] response in
            switch response.response?.statusCode {
            case 205:
                self?.requestProfileInfo()
            default:
                return
            }
        }
    }
    
    func pushChangePhoneNumber() {
        coordinator.navigate(to: .changePhoneNumberIsRequired)
    }
    
    func pushFindAddress() {
        coordinator.navigate(to: .findAddressIsRequired)
    }
}

