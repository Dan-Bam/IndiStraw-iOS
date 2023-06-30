import UIKit
import Alamofire
import AuthDomain

enum CrowdFundingTarget {
    case requestCrowdFundingList(CrowdFundingRequest)
}

extension CrowdFundingTarget: BaseRouter {
}
