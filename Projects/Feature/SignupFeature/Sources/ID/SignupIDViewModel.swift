import UIKit
import BaseFeature

class SignupIDViewModel: BaseViewModel {
    
    var image: UIImage?
    var name: String
    var phoneNumber: String
    
    init(coordinator: Coordinator, image: UIImage?, name: String, phoneNumber: String) {
        self.image = image
        self.name = name
        self.phoneNumber = phoneNumber
        super.init(coordinator: coordinator)
    }
    func pushPasswordVC() {
        coordinator.navigate(to: .inputPasswordIsRequired)
    }
}
