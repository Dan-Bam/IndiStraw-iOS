import Foundation
import BaseFeature

public class SignupNameCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SignupNameViewModel(coordinator: self)
        let vc = SignupNameViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
