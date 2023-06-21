import Foundation
import BaseFeature
import RxSwift
import RxCocoa
import Alamofire
import AuthDomain
import JwtStore

class AddressViewModel: BaseViewModel {
    var currentPage = 0
    func requestAddress(keyword: String) {
        AF.request(AddressTarget.searchAddress(
            RequestAddressModel(
                currentPage: currentPage,
                keyword: keyword
            )
        ))
        .validate()
        
    }
}
