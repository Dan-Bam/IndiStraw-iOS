import Foundation
import BaseFeature

class SignupInputIDCoordinator: BaseCoordinator {
    override func start() {
        let vm = SignupInputIDViewModel(coordinator: self)
        let vc = SignupInputIDViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
