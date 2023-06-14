import Foundation
import BaseFeature

class ChangePasswordCoordinator: BaseCoordinator {
    func startChangePasswordCoordinator(phoneNumber: String) {
        let vm = ChangePasswordViewModel(coordinator: self, phoneNumber: phoneNumber)
        let vc = ChangePasswordViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
