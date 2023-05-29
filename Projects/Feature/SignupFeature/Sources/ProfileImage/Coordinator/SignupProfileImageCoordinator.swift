import UIKit
import BaseFeature

class SignupProfileImageCoordinator: BaseCoordinator {
    override func start() {
        let vm = SignupProfileImageViewModel(coordinator: self)
        let vc = SignupProfileImageViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
