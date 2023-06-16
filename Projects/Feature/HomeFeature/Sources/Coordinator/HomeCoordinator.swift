import Foundation
import BaseFeature

class HomeCoordinator: BaseCoordinator {
    override func start() {
        let vm = HomeViewModel(coordinator: self)
        let vc = HomeViewController(viewModel: vm)
        
        navigationController.setViewControllers([vc], animated: true)
    }
}
