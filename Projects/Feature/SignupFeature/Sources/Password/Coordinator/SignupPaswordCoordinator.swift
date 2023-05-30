import Foundation
import BaseFeature

class SignupPaswordCoordinator: BaseCoordinator {
    override func start() {
        let vm = SignupPasswordViewModel(coordinator: self)
        let vc = SignupPasswordViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
