import Foundation
import BaseFeature
import Alamofire
import JwtStore
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    
    var myFundingListData = BehaviorRelay<[FundingModel]>(value: [])
    
    func reqeustMyFunding() {
        AF.request(ProfileTarget.requestMyFunding,
                   interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: [FundingModel].self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.myFundingListData.accept(data)
            case .failure(let error):
                print("Error - MyFunding = \(error.localizedDescription)")
            }
        }
    }
    
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
