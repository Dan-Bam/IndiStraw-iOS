import Foundation
import BaseFeature

class SignupPaswordCoordinator: BaseCoordinator {
    override func start() {
        let vm = SignupPasswordViewModel(coordinator: self)
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
