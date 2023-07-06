import Foundation
import BaseFeature
import RxSwift
import RxCocoa
import Alamofire
import JwtStore

class CrowdFundingDetailViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    var crowdFundingCurrentPage = -1
    var idx: Int
    
    init(coordinator: Coordinator, idx: Int) {
        self.idx = idx
        super.init(coordinator: coordinator)
    }
    
    func requestCrowdFundingDetailList() -> Observable<CrowdFundingDetailResponse> {
        return Observable.create { [weak self] (observer) -> Disposable in
            AF.request(
                CrowdFundingTarget.requestCrowdFundingDetail(idx: self!.idx),
                interceptor: JwtRequestInterceptor(jwtStore: self!.container))
            .validate()
            .responseDecodable(of: CrowdFundingDetailResponse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    print("Error - FundingDetail = \(error.localizedDescription)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
}
