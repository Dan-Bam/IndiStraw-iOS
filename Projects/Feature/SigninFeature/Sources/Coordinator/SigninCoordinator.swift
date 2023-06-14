import UIKit
import BaseFeature
import FindPasswordFeature

public class SigninCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SigninViewModel(coordinator: self)
        let vc = SigninViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .findPasswordIsRequired:
            findPasswordIsRequired()
        default:
            return
        }
    }
}

extension SigninCoordinator {
    func findPasswordIsRequired() {
        let vc = PasswordInputPhoneNumberCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
