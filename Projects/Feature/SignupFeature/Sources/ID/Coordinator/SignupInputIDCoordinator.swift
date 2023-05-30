import Foundation
import BaseFeature

class SignupInputIDCoordinator: BaseCoordinator {
    override func start() {
        let vm = SignupIDViewModel(coordinator: self)
        let vc = SignupIDViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
