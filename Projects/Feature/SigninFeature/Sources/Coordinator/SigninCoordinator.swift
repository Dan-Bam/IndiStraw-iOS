import UIKit
import BaseFeature
import PhoneNumberAuthFeature

public class SigninCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SigninViewModel(coordinator: self)
        let vc = SigninViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .phoneNumberAuthIsRequired:
            phoneNumberAuthIsRequired()
        default:
            return
        }
    }
}

extension SigninCoordinator {
    func phoneNumberAuthIsRequired() {
        let vc = InputPhoneNumberCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
