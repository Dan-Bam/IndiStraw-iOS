import BaseFeature

class CrowdFundingCoordinator: BaseCoordinator {
    override func start() {
        let vm = CrowdFundingViewModel(coordinator: self)
        let vc = CrowdFundingViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
