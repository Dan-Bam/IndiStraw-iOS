import BaseFeature

public class CrowdFundingCoordinator: BaseCoordinator {
    public func startCrowdFundingCoordinator(idx: Int) {
        let vm = CrowdFundingViewModel(coordinator: self, idx: idx)
        let vc = CrowdFundingViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
