import BaseFeature

public class CrowdFundingCoordinator: BaseCoordinator {
    public func startCrowdFundingDetailCoordinator(idx: Int) {
        let vm = CrowdFundingDetailViewModel(coordinator: self, idx: idx)
        let vc = CrowdFundingDetailViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    public func startCrowdFundingListCoordinator() {
        let vm = CrowdFundingViewAllViewModel(coordinator: self)
        let vc = CrowdFundingViewAllViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
