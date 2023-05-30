import Foundation
import BaseFeature

class SignupPhoneNumberCoordinator: BaseCoordinator {
    override func start() {
        let vm = SignupPhoneNumberViewModel(coordinator: self)
        let vc = SignupPhoneNumberViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
