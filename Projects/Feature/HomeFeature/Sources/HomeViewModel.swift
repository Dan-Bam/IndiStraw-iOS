import Foundation
import BaseFeature
import Alamofire
import JwtStore

class HomeViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    var crowdFundingCurrentPage = 0
    func requestCrowdFundingList() {
        AF.request(HomeTarget.requestCrowdFundingList, interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseDecodable(of: [FundingList].self) { response in
            print(response.response?.statusCode)
            switch response.result {
            case .success(let data):
                print("data = \(data)")
            case .failure(let error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
    
    func pushProfileVC() {
        coordinator.navigate(to: .profileIsRequired)
    }
}
