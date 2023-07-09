import Foundation
import BaseFeature
import Alamofire
import JwtStore
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestProfileName() -> Observable<String> {
        return Observable.create { [weak self] (observer) -> Disposable in
            AF.request(ProfileTarget.requestProfileName,
                       interceptor: JwtRequestInterceptor(jwtStore: self!.container))
            .validate()
            .responseDecodable(of: ProfileModel.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    observer.onNext(data.name)
                case .failure(let error):
                    print("Error - ProfileName = \(error.localizedDescription)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func pushSettingVC() {
        coordinator.navigate(to: .settingIsRequired)
    }
}
