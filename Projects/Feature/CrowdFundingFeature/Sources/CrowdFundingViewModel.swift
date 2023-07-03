import Foundation
import BaseFeature
import RxSwift
import RxCocoa
import Alamofire
import JwtStore

class CrowdFundingViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    var crowdFundingCurrentPage = -1
    var idx: Int
    
    
    init(coordinator: Coordinator, idx: Int) {
        self.idx = idx
        super.init(coordinator: coordinator)
    }
    
    func requestCrowdFundingList() -> Observable<CrowdFundingDetailResponse> {
        return Observable.create { [weak self] (observer) -> Disposable in
            AF.request(
                CrowdFundingTarget.requestCrowdFundingDetail(idx: self!.idx),
                interceptor: JwtRequestInterceptor(jwtStore: self!.container))
            .validate()
            .responseDecodable(of: CrowdFundingDetailResponse.self) { [weak self] response in
                switch response.result {
                case .success(let data):
                    print("success")
                    observer.onNext(data)
                case .failure(let error):
                    print("error = \(response.response?.statusCode)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
}
