import UIKit
import BaseFeature

public class SignupProfileImageCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SignupProfileImageViewModel(coordinator: self)
        let vc = SignupProfileImageViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public override func navigate(to step: IndiStrawStep) {
        switch step {
        case .inputIDIsRequired:
            inputIDIsRequired()
        default:
            return
        }
    }
}

extension SignupProfileImageCoordinator {
    func inputIDIsRequired() {
        let vc = SignupIDCoordiantor(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
