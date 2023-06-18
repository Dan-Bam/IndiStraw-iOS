import Foundation
import BaseFeature

public class HomeCoordinator: BaseCoordinator {
    public override func start() {
        let vm = HomeViewModel(coordinator: self)
        let vc = HomeViewController(viewModel: vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
}
