import UIKit
import BaseFeature

public class RootCoordinator: BaseCoordinator {
    public override func start() {
        let vm = RootViewModel(coordinator: self)
        let vc = RootViewController(viewModel: vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
}
