import UIKit
import BaseFeature

public class SignupProfileImageCoordinator: BaseCoordinator {
    public override func start() {
        let vm = SignupProfileImageViewModel(coordinator: self)
        let vc = SignupProfileImageViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
