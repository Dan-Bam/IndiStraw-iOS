import UIKit
import BaseFeature
import Alamofire

public class SignupProfileViewModel: BaseViewModel {
    
    var name: String
    var phoneNumber: String
    
    public init(coordinator: Coordinator, name: String, phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        super.init(coordinator: coordinator)
    }
    
    func pushInputIDVC(image: UIImage?) {
        coordinator.navigate(to: .inputIDIsRequired(image: image, name: name, phoneNumber: phoneNumber))
    }
}
    
