import Foundation
import BaseFeature
import SignupFeature

public class SignupNameCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SignupNameViewModel(coordinator: self)
        let vc = SignupNameViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .inputPhoneNumberIsRequired(let name):
            inputPhoneNumberIsRequired(name: name)
        default:
            return
        }
    }
}

extension SignupNameCoordinator {
    func inputPhoneNumberIsRequired(name: String) {
        let vc = SignupPhoneNumberCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.startSignupPhoneNumberVC(name: name)
    }
}
