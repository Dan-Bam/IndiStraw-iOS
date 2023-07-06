import Foundation
import BaseFeature
import JwtStore
import RxSwift
import RxCocoa
import Alamofire

class CrowdFundingViewAllViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    let fundingListCurrentPage = -1
    
    func requestCrowdFundingList() -> Observable<[FundingDataList]> {
        return Observable.create { [weak self] (observer) -> Disposable in
            AF.request(
                CrowdFundingTarget.requestCrowdFundingList(CrowdFundingListRequest(page: self!.fundingListCurrentPage)),
                interceptor: JwtRequestInterceptor(jwtStore: self!.container))
            .validate()
            .responseDecodable(of: [FundingDataList].self) { [weak self] response in
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
