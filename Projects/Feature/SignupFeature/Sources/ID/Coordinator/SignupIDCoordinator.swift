import Foundation
import BaseFeature

class SignupIDCoordinator: BaseCoordinator {
    override func start() {
        let vm = SignupIDViewModel(coordinator: self)
        let vc = SignupIDViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
