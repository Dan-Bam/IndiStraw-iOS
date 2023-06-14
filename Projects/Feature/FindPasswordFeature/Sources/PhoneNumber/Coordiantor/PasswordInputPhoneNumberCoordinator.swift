import Foundation
import BaseFeature

public class InputPhoneNumberCoordinator: BaseCoordinator {
    public override func start() {
        let vm = InputPhoneNumberViewModel(coordinator: self)
        let vc = InputPhoneNumberViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
