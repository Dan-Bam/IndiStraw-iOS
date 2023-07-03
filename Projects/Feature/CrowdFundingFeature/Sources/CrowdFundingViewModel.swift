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
    
    func requestCrowdFundingList() {
        AF.request(
            CrowdFundingTarget.requestCrowdFundingDetail(idx: idx),
            interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: CrowdFundingDetailResponse.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                print("success")
            case .failure(let error):
                print("error = \(response.response?.statusCode)")
            }
        }
    }
}
