import UIKit
import BaseFeature
import SignupFeature

public class SignupPaswordCoordinator: BaseCoordinator {
    public func startSignupPaswordCoordinator(id: String, name: String, phoneNumber: String, profileImage: UIImage?) {
        let vm = SignupPasswordViewModel(coordinator: self)
        let vc = SignupPasswordViewController(viewModel: vm, id: id, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public  override func navigate(to step: IndiStrawStep) {
        switch step {
        case .popToRootIsRequired:
            popToRootIsRequired()
        default:
            return
        }
    }
}

extension SignupPaswordCoordinator {
    func popToRootIsRequired() {
        navigationController.popToRootViewController(animated: true)
    }
}

