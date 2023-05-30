import Foundation
import BaseFeature

public class SignupNameCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SignupNameViewModel(coordinator: self)
        let vc = SignupNameViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .inputPhoneNumberIsRequired:
            inputPhoneNumberIsRequired()
        default:
            return
        }
    }
}

extension SignupNameCoordinator {
    func inputPhoneNumberIsRequired() {
        let vc = SignupPhoneNumberCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
