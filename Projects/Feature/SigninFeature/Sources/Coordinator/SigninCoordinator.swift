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
        case .findPassword_phoneNumberIsRequired:
            findPassword_phoneNumberIsRequired()
        default:
            return
        }
    }
}

extension SigninCoordinator {
    func findPassword_phoneNumberIsRequired() {
        let vc = InputPhoneNumberCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
