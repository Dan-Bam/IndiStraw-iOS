import BaseFeature

public class CrowdFundingCoordinator: BaseCoordinator {
    public override func start() {
        let vm = CrowdFundingViewModel(coordinator: self)
        let vc = CrowdFundingViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
