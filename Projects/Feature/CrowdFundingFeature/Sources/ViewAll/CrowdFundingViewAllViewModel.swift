import Foundation
import BaseFeature
import JwtStore
import RxSwift
import RxCocoa
import Alamofire

public class CrowdFundingViewAllViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    let fundingListCurrentPage = 0
    
    func requestCrowdFundingList() -> Observable<[FundingList]> {
        return Observable.create { [weak self] (observer) -> Disposable in
            AF.request(
                CrowdFundingTarget.requestCrowdFundingList(CrowdFundingListRequest(page: self!.fundingListCurrentPage)),
                interceptor: JwtRequestInterceptor(jwtStore: self!.container))
            .validate()
            .responseDecodable(of: CrowdFundingListResopnse.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data.list)
                case .failure(let error):
                    print("Error - CrowdFundingList = \(error.localizedDescription)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func pushCrowdFundingDetailVC(idx: Int) {
        coordinator.navigate(to: .crowdFundingDetailIsRequired(idx: idx))
    }
}
