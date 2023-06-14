import Foundation
import BaseFeature

public class PasswordInputPhoneNumberCoordinator: BaseCoordinator {
    public override func start() {
        let vm = PasswordInputPhoneNumberViewModel(coordinator: self)
        let vc = PasswordInputPhoneNumberViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
