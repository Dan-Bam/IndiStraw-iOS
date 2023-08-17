import Foundation
import BaseFeature
import JwtStore
import Alamofire

public class DetailAddressViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestToChangeAddress(data: ChangeAddressModel) {
        AF.request(AddressTarget.changeAddress(
            ChangeAddressModel(
                zipcode: data.zipcode,
                streetAddress: data.streetAddress,
                detailAddress: data.detailAddress)
        ), interceptor: JwtRequestInterceptor(jwtStore: container))
        .validate()
        .responseData { [weak self] response in
            switch response.response?.statusCode {
            case 205:
                self?.popView()
            default:
                print("Error - ChangeAddress")
            }
        }
    }
    
    func popView() {
        coordinator.navigate(to: .popViewIsRequired)
    }
}
