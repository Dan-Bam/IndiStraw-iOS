import Foundation
import BaseFeature
import Alamofire
import JwtStore

class HomeViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    var crowdFundingCurrentPage = 0
    func requestCrowdFundingList(completion: @escaping (Result<[FundingList], Error>) -> Void) {
        AF.request(HomeTarget.requestCrowdFundingList, interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: [FundingList].self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("Popular CrowdFunding List - error = \(error.localizedDescription)")
            }
        }
    }
    
    func pushMovieDetailVC() {
        coordinator.navigate(to: .movieDetailISRequired)
    }
    
    func pushCrowdFundingDetailVC(idx: Int) {
        coordinator.navigate(to: .crowdFundingDetailIsRequired(idx: idx))
    }
    
    func pushCrowdFundingListVC() {
        coordinator.navigate(to: .crowdFundingListIsRequired)
    }
    
    func pushProfileVC() {
        coordinator.navigate(to: .profileIsRequired)
    }
}
