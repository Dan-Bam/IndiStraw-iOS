import UIKit
import BaseFeature
import SignupFeature

public class SignupProfileCoordinator: BaseCoordinator {
    public func startSignupProfileImageCoordinator(name: String, phoneNumber: String) {
        let vm = SignupProfileViewModel(coordinator: self, name: name, phoneNumber: phoneNumber)
        let vc = SignupProfileViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .inputIDIsRequired(let image, let name, let phoneNumber):
            inputIDIsRequired(image: image, name: name, phoneNumber: phoneNumber)
        default:
            return
        }
    }
}

extension SignupProfileCoordinator {
    func inputIDIsRequired(image: UIImage?, name: String, phoneNumber: String) {
        let vc = SignupIDCoordiantor(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startSignupIDCoordiantor(image: image, name: name, phoneNumber: phoneNumber)
    }
}
