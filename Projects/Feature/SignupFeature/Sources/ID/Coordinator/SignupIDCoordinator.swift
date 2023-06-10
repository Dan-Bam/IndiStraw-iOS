import Foundation
import BaseFeature

public class SignupIDCoordiantor: BaseCoordinator {
    public  override func start() {
        let vm = SignupIDViewModel(coordinator: self)
        let vc = SignupIDViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public  override func navigate(to step: IndiStrawStep) {
        switch step {
        case .inputPasswordIsRequired:
            inputPasswordIsRequired()
        default:
            return
        }
    }
}

extension SignupIDCoordiantor {
    func inputPasswordIsRequired() {
        let vc = SignupPaswordCoordinator(navigationController: navigationController)
        vc.parentCoordinator = self
        childCoordinators.append(vc)
        vc.start()
    }
}
