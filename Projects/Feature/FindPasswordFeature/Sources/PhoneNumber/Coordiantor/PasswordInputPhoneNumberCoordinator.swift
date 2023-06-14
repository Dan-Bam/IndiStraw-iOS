import Foundation
import BaseFeature

class PasswordInputPhoneNumberCoordinator: BaseCoordinator {
    override func start() {
        let vm = PasswordInputPhoneNumberViewModel(coordinator: self)
        let vc = PasswordInputPhoneNumberViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
