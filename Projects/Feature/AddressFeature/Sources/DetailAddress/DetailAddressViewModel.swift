import Foundation
import BaseFeature
import JwtStore

class DetailAddressViewModel: BaseViewModel {
    let container = DIContainer.shared.resolve(JwtStore.self)!
    
    func requestToChangeAddress(data: ChangeAddressModel) {
        
    }
}
