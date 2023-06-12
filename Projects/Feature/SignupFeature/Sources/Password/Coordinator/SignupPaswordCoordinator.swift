import UIKit
import BaseFeature

class SignupPaswordCoordinator: BaseCoordinator {
    func startSignupPaswordCoordinator(id: String, name: String, phoneNumber: String, profileImage: UIImage?) {
        let vm = SignupPasswordViewModel(coordinator: self, id: id, name: name, phoneNumber: phoneNumber, profileImage: profileImage)
        let vc = SignupPasswordViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: IndiStrawStep) {
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

