import Foundation
import BaseFeature
import RxSwift
import RxCocoa
import Alamofire

class CrowdFundingViewModel: BaseViewModel {
    var crowdFundingCurrentPage = -1
    var idx: Int
    
    init(coordinator: Coordinator, idx: Int) {
        self.idx = idx
        super.init(coordinator: coordinator)
    }
    
//    func requestCrowdFundingList() {
//        AF.request(CrowdFundingTarget.requestCrowdFundingList(
//            CrowdFundingRequest(page: crowdFundingCurrentPage)))
//    }
}
